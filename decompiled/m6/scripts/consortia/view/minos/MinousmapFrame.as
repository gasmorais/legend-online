package consortia.view.minos
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.minos.ui.MinosMapViewUI;
   import consortia.view.minos.ui.MinosTopLeftUI;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import managers.MinosManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.MinosLevelTempInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class MinousmapFrame extends Frame implements IManualSize
   {
      
      private var _bigbg:Bitmap;
      
      private var _titlebg:Bitmap;
      
      private var _enterTopLeft:MinosTopLeftUI;
      
      private var _nodeMapView:MinosMapViewUI;
      
      private var _lv:int;
      
      public function MinousmapFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1262,742);
      }
      
      private function initView() : void
      {
         MinosBitDataUtils.Ins.init();
         _bigbg = ComponentFactory.Instance.creatBitmap("asset.minos.bigbg");
         _titlebg = ComponentFactory.Instance.creatBitmap("asset.minos.title");
         _enterTopLeft = ComponentFactory.Instance.creatCustomObject("ui.minos.enterTopLeft");
         _nodeMapView = ComponentFactory.Instance.creatCustomObject("ui.minos.MinosMapViewUI");
         addToContent(_bigbg);
         addToContent(_titlebg);
         addToContent(_enterTopLeft);
         addToContent(_nodeMapView);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         playerInfo.removeEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function __existConsortiaHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID == 0)
         {
            dispose();
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bigbg);
         _bigbg = null;
         ObjectUtils.disposeObject(_enterTopLeft);
         _enterTopLeft = null;
         ObjectUtils.disposeObject(_nodeMapView);
         _nodeMapView = null;
         ObjectUtils.disposeObject(_titlebg);
         _titlebg = null;
         super.dispose();
         MinosManager.ins.doSomething(4,_lv);
         MinosBitDataUtils.Ins.clear();
      }
      
      public function show(param1:int) : void
      {
         _lv = param1;
         var _loc2_:MinosLevelTempInfo = TempleteManager.instance.minosLevelCate.getTemplateByID(_lv);
         _nodeMapView.temp = _loc2_;
         MinosManager.ins.model.currBattleLv = _lv;
         MinosManager.ins.doSomething(3,_lv);
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP"];
      }
   }
}

