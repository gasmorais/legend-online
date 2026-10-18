package fund
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.FundManager;
   import mvc.module.fund.ActiveParmaInfo;
   import mvc.module.fund.FundInfo;
   import mvc.module.fund.GItemInfo;
   import mvc.module.fund.GLogInfo;
   import mvc.module.fund.GetItemInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.utils.DateFormatter;
   
   public class FundRewardView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _actGetTimeTxt:FilterFrameText;
      
      private var _rewardHbox:HBox;
      
      private var _lineImg:Bitmap;
      
      private var _vBox:VBox;
      
      private var _totalGet:GradientText;
      
      private var _hbox:HBox;
      
      private var _model:FundInfo;
      
      private var _itemDic:Dictionary;
      
      private var _isNewbie:Boolean = FundManager.instance.isNewbie;
      
      public function FundRewardView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         if(_isNewbie)
         {
            _model = FundManager.instance.newbieModel;
         }
         else
         {
            _model = FundManager.instance.model;
         }
         _bg = ComponentFactory.Instance.creatComponentByStylename("fund.bg2");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("fund.rewardPanel");
         _lineImg = ComponentFactory.Instance.creatBitmap("asset.fund.LightLine");
         _actGetTimeTxt = ComponentFactory.Instance.creatComponentByStylename("fund.getrewardTimeTxt");
         _totalGet = ComponentFactory.Instance.creatComponentByStylename("fund.totalGet");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("fund.itemVBox");
         _totalGet.text = LanguageMgr.GetTranslation("fund.FundRewardView.totalGet.text");
         _actGetTimeTxt.text = LanguageMgr.GetTranslation("fund.FundRewardView.actGetTimeTxt.text") + DateFormatter.transDate(_model.getStartDate) + LanguageMgr.GetTranslation("fund.FundRewardView.getTime.line") + DateFormatter.transDate(_model.getEndDate);
         addChild(_bg);
         _bg.height = 285;
         addChild(_lineImg);
         addChild(_actGetTimeTxt);
         addChild(_totalGet);
         _vBox = new VBox();
         sortArray();
         _scrollPanel.setView(_vBox);
         addChild(_scrollPanel);
         if(_isNewbie)
         {
            _actGetTimeTxt.visible = false;
         }
         __refresh(null);
      }
      
      private function sortArray() : void
      {
         var _loc3_:int = 0;
         var _loc2_:FundRewardItem = null;
         _vBox.removeAllChild();
         var _loc1_:Array = setisGet(_model.activeArr[_model.depositLevel - 1].getInfos);
         _loc1_.sortOn(["_isGet","times"],16);
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = new FundRewardItem();
            _loc2_.data = _loc1_[_loc3_];
            _vBox.addChild(_loc2_);
            _loc3_++;
         }
      }
      
      private function setisGet(param1:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc6_:GetItemInfo = null;
         var _loc8_:Array = null;
         var _loc3_:int = 0;
         var _loc7_:GLogInfo = null;
         var _loc5_:int = 0;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc6_ = param1[_loc4_] as GetItemInfo;
            _loc8_ = _model.getLogArr;
            _loc3_ = int(_loc8_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc7_ = _loc8_[_loc5_] as GLogInfo;
               if(_loc7_.type == _loc6_.times)
               {
                  _loc6_._isGet = 1;
               }
               _loc5_++;
            }
            _loc2_.push(_loc6_);
            _loc4_++;
         }
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _bg = null;
         _scrollPanel = null;
         _actGetTimeTxt = null;
         _rewardHbox = null;
         _lineImg = null;
         _totalGet = null;
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("FUND_REFRESH",__refresh);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("FUND_REFRESH",__refresh);
      }
      
      private function __refresh(param1:NotificationEvent) : void
      {
         var _loc8_:int = 0;
         var _loc5_:GItemInfo = null;
         var _loc3_:FundItem = null;
         var _loc11_:int = 0;
         var _loc4_:Array = null;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc14_:GItemInfo = null;
         var _loc12_:FundItem = null;
         var _loc7_:int = 0;
         var _loc2_:ActiveParmaInfo = _model.getActiveByLevel(_model.depositLevel);
         var _loc10_:Array = _model.hasGetInfo;
         if(_hbox)
         {
            _hbox.parent.removeChild(_hbox);
            _hbox = null;
         }
         _hbox = new HBox();
         _hbox.x = 358;
         _hbox.y = 403;
         _hbox.spacing = 12;
         var _loc13_:int = int(_loc10_.length);
         if(_loc10_ && _loc13_ > 0)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc13_)
            {
               _loc5_ = _loc10_[_loc8_];
               _loc3_ = new FundItem();
               _loc11_ = int(_loc5_.templateId);
               _hbox.addChild(_loc3_);
               _loc3_.show({
                  "type":"2",
                  "num":_loc5_.count + "",
                  "itemTempleteId":_loc11_
               });
               _loc8_++;
            }
         }
         else
         {
            _loc4_ = _loc2_.totalGetInfo;
            _loc6_ = int(_loc4_.length);
            _loc9_ = 0;
            while(_loc9_ < _loc6_)
            {
               _loc14_ = _loc4_[_loc9_];
               _loc12_ = new FundItem();
               _hbox.addChild(_loc12_);
               _loc7_ = int(_loc14_.templateId);
               _loc12_.show({
                  "type":"2",
                  "num":"0",
                  "itemTempleteId":_loc7_
               });
               _loc9_++;
            }
         }
         addChild(_hbox);
         resetSize();
         sortArray();
      }
      
      private function resetSize() : void
      {
         _hbox.x = 330 + (200 - _hbox.width) / 2;
      }
   }
}

