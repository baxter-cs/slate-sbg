Ext.define('Slate.sbg.overrides.TermReportSectionsGrid', {
    override: 'SlateAdmin.view.progress.terms.SectionsGrid',
    requires: [
        'Ext.grid.plugin.CellEditing',
        'Ext.form.field.ComboBox'
    ],

    width: 300,
    worksheetColumnTitle: 'Worksheet',
    emptyWorksheetText: '<em>Double-click to select</em>',

    initComponent: function() {
        var me = this;

        me.columns = me.columns.concat({
            text: me.worksheetColumnTitle,
            dataIndex: 'WorksheetID',
            emptyCellText: me.emptyWorksheetText,
            width: 200,
            editor: {
                xtype: 'combo',
                allowBlank: true,
                emptyText: 'Select worksheet',

                store: 'StandardsWorksheets',
                displayField: 'Title',
                valueField: 'ID',

                queryMode: 'local',
                triggerAction: 'all',
                typeAhead: true,
                forceSelection: true,
                selectOnFocus: true
            },
            renderer: function(worksheetId, metaData, section) {
                if (!worksheetId) {
                    return null;
                }

                var worksheet = section.get('worksheet');

                if (!worksheet) {
                    return '[Deleted Worksheet]';
                }

                return worksheet.get('Title');
            }
        });

        me.plugins = (me.plugins || []).concat({
            ptype: 'cellediting',
            clicksToEdit: 2
        });

        me.callParent(arguments);
    }
});