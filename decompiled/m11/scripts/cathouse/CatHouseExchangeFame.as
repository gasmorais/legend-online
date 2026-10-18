package cathouse
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.CatHouseTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class CatHouseExchangeFame extends Frame
   {
      
      private var _vBox:VBox;
      
      public function CatHouseExchangeFame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,451,457);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _vBox = new VBox();
         _vBox.spacing = -1;
         addToContent(_vBox);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("CLOSE_EXCHANGE_FRAME",__closeExchangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("CLOSE_EXCHANGE_FRAME",__closeExchangeHandler);
      }
      
      private function refreshView(param1:int) : void
      {
         var _loc3_:CatHouseExchangeItem = null;
         var _loc4_:int = 0;
         ObjectUtils.disposeAllChildren(_vBox);
         var _loc2_:Vector.<CatHouseTemplateInfo> = TempleteManager.instance.catHouseTemplateCate.getTemplatesByType(param1);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("cathouse.CatHouseExchangeItem",[CatHouseTemplateInfo(_loc2_[_loc4_])]);
            _loc3_.type = param1;
            _vBox.addChild(_loc3_);
            _loc4_++;
         }
      }
      
      private function __closeExchangeHandler(param1:NotificationEvent = null) : void
      {
         dispose();
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
      
      public function show(param1:int) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("cathouse.CatHouseExchangeFame.titleText" + param1);
         refreshView(param1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         super.dispose();
      }
   }
}

