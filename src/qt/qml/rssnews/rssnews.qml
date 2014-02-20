/****************************************************************************
**
** Copyright (C) 2012 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the QtDeclarative module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** GNU Lesser General Public License Usage
** This file may be used under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation and
** appearing in the file LICENSE.LGPL included in the packaging of this
** file. Please review the following information to ensure the GNU Lesser
** General Public License version 2.1 requirements will be met:
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights. These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU General
** Public License version 3.0 as published by the Free Software Foundation
** and appearing in the file LICENSE.GPL included in the packaging of this
** file. Please review the following information to ensure the GNU General
** Public License version 3.0 requirements will be met:
** http://www.gnu.org/copyleft/gpl.html.
**
** Other Usage
** Alternatively, this file may be used in accordance with the terms and
** conditions contained in a signed written agreement between you and Nokia.
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.0
import "content"

Rectangle {
    id: window
    width: 400; height: 600

    property string currentFeed: "feeds.feedburner.com/UnitecoinNews?format=xml"
    property bool loading: feedModel.status == XmlListModel.Loading

    XmlListModel {
        id: feedModel
        source: "http://" + window.currentFeed
        namespaceDeclarations: "declare default element namespace 'http://www.w3.org/2005/Atom';"
        query: "/feed/entry"

        XmlRole { name: "id"; query: "id/string()"; isKey: true }
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "author"; query: "author/name/string()" }
        XmlRole { name: "link"; query: "link/@href/string()" }
        XmlRole { name: "description"; query: "content/string()" }
    }

    Row {
        ListView {
            id: list
            width: window.width; height: window.height
            model: feedModel
            delegate: NewsDelegate {}
        }
    }
    ScrollBar { scrollArea: list; height: list.height; width: 8; anchors.right: window.right }
}
