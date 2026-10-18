package christmas
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import utils.LogicUtils;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ChristmasManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.HRollItemPanel;
   import yishi.view.base.TextAddBitmap;
   
   public class ChristmasGiftFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _allCountTxt:FilterFrameText;
      
      private var _allCount:TextAddBitmap;
      
      private var _resttxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _hPanel:HRollItemPanel;
      
      private var _tempList:Array;
      
      private var _dic:Dictionary = new Dictionary();
      
      public function ChristmasGiftFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1043,651);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("christmasGiftFrame.bg");
         _allCountTxt = ComponentFactory.Instance.creatComponentByStylename("christmasGiftFrame.rechargeCountTxt");
         _allCount = ComponentFactory.Instance.creatCustomObject("christmasGiftFrame.allCountBit");
         _allCount.initView("christmasGiftFrame.pointNumTx","asset.core.SmallPointImg");
         _resttxt = ComponentFactory.Instance.creatComponentByStylename("christmasGiftFrame.retTimeTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("christmasGiftFrame.timeTxt");
         _hPanel = ComponentFactory.Instance.creatCustomObject("christmasGiftFrame.RollPanel");
         _hPanel.initParams("christmasGiftFrame.RollPanel.HBox","christmasGiftFrame.RollPanel.LeftBtn","christmasGiftFrame.RollPanel.RightBtn",3,304,600,5);
         addToContent(_bg);
         addToContent(_allCountTxt);
         addToContent(_allCount);
         addToContent(_resttxt);
         addToContent(_timeTxt);
         addToContent(_hPanel);
         _allCountTxt.text = LanguageMgr.GetTranslation("carnival.today");
         _resttxt.htmlText = LanguageMgr.GetTranslation("carnival.today.reset");
         _timeTxt.htmlText = LanguageMgr.GetTranslation("ChristmasFrame.timeTxt.text",model.openTimeStr,model.stopTimeStr);
         initData();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         ChristmasManager.instance.addEventListener("EVENT_UPDATE",updateInfoHandler);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         ChristmasManager.instance.removeEventListener("EVENT_UPDATE",updateInfoHandler);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function __refreshTopToolsHandler(param1:NotificationEvent) : void
      {
         if(!model.isOpen)
         {
            dispose();
         }
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc4_:ChristmasActivitiesTempInfo = null;
         var _loc3_:int = 0;
         var _loc1_:int = int(model.dayCharge);
         _allCount.setText("" + _loc1_);
         var _loc2_:int = int(_tempList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _tempList[_loc3_];
            _dic[_loc4_.Id].refreshView();
            _loc3_++;
         }
      }
      
      private function initData() : void
      {
         var _loc7_:ChristmasActivitiesTempInfo = null;
         var _loc2_:ChristmasGiftItem = null;
         var _loc4_:Sprite = null;
         var _loc5_:int = 0;
         _tempList = TempleteManager.instance.christmasActivitiesTempCate.getTemplatesByType(2);
         var _loc3_:int = int(_tempList ? _tempList.length : 0);
         var _loc1_:Array = [];
         var _loc6_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc7_ = _tempList[_loc5_];
            if(_loc4_)
            {
               if(++_loc6_ >= 2)
               {
                  _loc6_ = 0;
                  _loc4_ = new Sprite();
                  _loc1_.push(_loc4_);
               }
            }
            else
            {
               _loc6_ = 0;
               _loc4_ = new Sprite();
               _loc1_.push(_loc4_);
            }
            _loc2_ = new ChristmasGiftItem(_loc5_ + 1);
            _loc2_.data = _loc7_;
            if(_loc4_.numChildren > 0)
            {
               _loc2_.y = 236;
            }
            _loc4_.addChild(_loc2_);
            _dic[_loc7_.Id] = _loc2_;
            _loc5_++;
         }
         _hPanel.updateList(_loc1_);
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_allCountTxt);
         _allCountTxt = null;
         ObjectUtils.disposeObject(_allCount);
         _allCount = null;
         ObjectUtils.disposeObject(_resttxt);
         _resttxt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_hPanel);
         _hPanel = null;
         LogicUtils.disposeDisplayCollection(_dic);
         _dic = null;
         super.dispose();
         _tempList = null;
      }
   }
}

