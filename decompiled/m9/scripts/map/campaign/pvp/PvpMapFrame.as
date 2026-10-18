package map.campaign.pvp
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   
   public class PvpMapFrame extends Frame implements IManualSize
   {
      
      private var _list:PvpSortListView;
      
      private var _bg3:PvpSettlementAwardView;
      
      private var _type:int;
      
      public function PvpMapFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         beginChanges();
         _list.updateSizeByType(param1);
         if(param1 == 1)
         {
            titleText = LanguageMgr.GetTranslation("map.campaign.pvp.title01");
            width = 590;
            height = 462;
            if(_bg3 && _bg3.parent)
            {
               _bg3.parent.removeChild(_bg3);
            }
         }
         else if(param1 == 2)
         {
            titleText = LanguageMgr.GetTranslation("map.campaign.pvp.title02");
            width = 590;
            height = 487;
            if(_bg3)
            {
               addToContent(_bg3);
            }
         }
         commitChanges();
      }
      
      private function initView() : void
      {
         _list = new PvpSortListView();
         _list.x = 2;
         _list.y = -4;
         addToContent(_list);
         _bg3 = new PvpSettlementAwardView();
      }
      
      private function addEvent() : void
      {
         this.addEventListener("response",__responseHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,false,0,0,true);
      }
      
      override public function dispose() : void
      {
         this.removeEventListener("response",__responseHandler);
         super.dispose();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,this.width,this.height);
      }
   }
}

