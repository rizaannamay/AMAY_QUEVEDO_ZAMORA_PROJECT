using System;
using System.Collections.Generic;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Pinned : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPinnedItems();
            }
        }

        private void LoadPinnedItems()
        {
            // Logic to fetch only items where 'IsPinned == true'
            // Example: repeaterPinned.DataSource = GetPinnedFromDB();
            // repeaterPinned.DataBind();
        }
    }
}