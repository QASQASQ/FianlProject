/**
 * 
 */

var customInternalNode =
    '<div class="tui-tree-content-wrapper tui-tree-root-btn" style="padding-left: {{indent}}px">' +
        '<button type="button" class="tui-tree-toggle-btn tui-js-tree-toggle-btn">' +
            '<span class="tui-ico-tree"></span>' +
            '{{stateLabel}}' +
        '</button>' +
        '<span class="tui-tree-text tui-js-tree-text">' +
            '{{text}}' +
        '</span>' +
    '</div>' +
    '<ul class="tui-tree-subtree tui-js-tree-subtree">' +
        '{{{children}}}' + // Mustache's format
    '</ul>';

var customLeafNode =
    '<div class="tui-tree-content-wrapper tui-tree-root-btn" style="padding-left: {{indent}}px">' +
        '<span class="tui-tree-text tui-js-tree-text">' +
            '{{text}}' +
        '</span>' +
    '</div>';