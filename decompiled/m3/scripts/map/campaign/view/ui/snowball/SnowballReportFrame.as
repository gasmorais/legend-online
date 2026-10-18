package map.campaign.view.ui.snowball
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.SevenYearManager;
   import map.campaign.view.ui.snowball.item.SnowReportItem;
   import mvc.module.sevenyear.SevenYearModel;
   import mvc.module.sevenyear.SnowVehicleReportInfo;
   import yishi.datas.ConfigInfoManager;
   
   public class SnowballReportFrame extends Frame
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _vbox:VBox;
      
      private var _alertText:FilterFrameText;
      
      private var showCount:int = 4;
      
      private var maxPoint:int;
      
      public function SnowballReportFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("SnowballReportFrame.border");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("SnowballReportFrame.vbox");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("SnowballReportFrame.alertText");
         addToContent(_border);
         addToContent(_vbox);
         addToContent(_alertText);
         maxPoint = ConfigInfoManager.instance.getSnowVehicleDailyRewardMax();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
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
      
      private function refreshView(param1:SnowVehicleReportInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:SnowReportItem = null;
         _vbox.removeAllChild();
         _loc3_ = 0;
         while(_loc3_ < showCount)
         {
            _loc2_ = new SnowReportItem(_loc3_ + 1);
            _loc2_.data = param1;
            _vbox.addChild(_loc2_);
            _loc3_++;
         }
         if(model.snowScore >= maxPoint)
         {
            this.height = 492;
            _alertText.text = LanguageMgr.GetTranslation("SnowballReportFrame.alertText.text");
         }
         else
         {
            this.height = 470;
            _alertText.text = "";
         }
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function show(param1:SnowVehicleReportInfo) : void
      {
         refreshView(param1);
         LayerManager.Instance.addToLayer(this,3,true,true);
         this.titleText = LanguageMgr.GetTranslation("SnowballReportFrame.titleText.text");
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         super.dispose();
      }
   }
}

