package fund
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.FundManager;
   import mvc.module.fund.ActiveParmaInfo;
   import mvc.module.fund.FundInfo;
   import mvc.module.fund.GLogInfo;
   import mvc.module.fund.GetItemInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.utils.DateFormatter;
   
   public class FundNewRewardView extends Component
   {
      
      public static const NUMBER:int = 5;
      
      private var _bg:Bitmap;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _actGetTimeTxt:FilterFrameText;
      
      private var _helpTxt:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _model:FundInfo;
      
      public function FundNewRewardView()
      {
         super();
         _model = FundManager.instance.model;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.fundnew.rewardBg");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("fundnew.rewardPanel");
         _actGetTimeTxt = ComponentFactory.Instance.creatComponentByStylename("fund.getrewardTimeTxt");
         _helpTxt = ComponentFactory.Instance.creatComponentByStylename("fund.helpTxt");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("fund.itemVBox");
         addChild(_bg);
         addChild(_actGetTimeTxt);
         addChild(_helpTxt);
         _vBox = new VBox();
         _vBox.width = 400;
         _actGetTimeTxt.x = 6;
         _actGetTimeTxt.y = 328;
         _helpTxt.text = LanguageMgr.GetTranslation("fund.FundNewRewardView.promptTxt.text");
         _actGetTimeTxt.text = LanguageMgr.GetTranslation("fund.FundRewardView.actGetTimeTxt.text") + DateFormatter.transDate(_model.getStartDate) + LanguageMgr.GetTranslation("fund.FundRewardView.getTime.line") + DateFormatter.transDate(_model.getEndDate);
         _bg.height = 318;
         sortArray();
         _scrollPanel.setView(_vBox);
         addChild(_scrollPanel);
      }
      
      private function uninitView() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_scrollPanel)
         {
            ObjectUtils.disposeObject(_scrollPanel);
         }
         _scrollPanel = null;
         if(_helpTxt)
         {
            ObjectUtils.disposeObject(_helpTxt);
         }
         _helpTxt = null;
         if(_actGetTimeTxt)
         {
            ObjectUtils.disposeObject(_actGetTimeTxt);
         }
         _actGetTimeTxt = null;
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
         sortArray();
      }
      
      private function sortArray() : void
      {
         var _loc2_:ActiveParmaInfo = null;
         var _loc1_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:FundNewRewardItem = null;
         if(_vBox)
         {
            _vBox.disposeAllChildren();
         }
         if(_model.newActiveArr && _model.newActiveArr[5 - _model.depositLevel])
         {
            _loc2_ = _model.newActiveArr[5 - _model.depositLevel];
         }
         if(_loc2_ && _loc2_.newGetInfos)
         {
            _loc1_ = setisGet(_loc2_.newGetInfos);
         }
         if(_loc1_)
         {
            _loc1_.sortOn(["_isGet","times"],16);
         }
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc3_ = new FundNewRewardItem();
            if(_loc1_ && _loc1_[_loc4_])
            {
               _loc3_.data = _loc1_[_loc4_];
            }
            else
            {
               _loc3_.data = null;
            }
            _vBox.addChild(_loc3_);
            _loc4_++;
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
         if(!param1)
         {
            return _loc2_;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc6_ = param1[_loc4_] as GetItemInfo;
            _loc8_ = _model.getNewLogArr;
            _loc3_ = int(_loc8_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc7_ = _loc8_[_loc5_] as GLogInfo;
               if(_loc7_.type == _loc6_.times)
               {
                  if(_loc7_.sort == 1)
                  {
                     _loc6_.getA = 1;
                     _loc6_.getB = 3;
                     FundManager.instance.getFlag = true;
                     FundManager.instance.getIndex = 1;
                  }
                  if(_loc7_.sort == 2)
                  {
                     _loc6_.getA = 3;
                     _loc6_.getB = 1;
                     FundManager.instance.getFlag = true;
                     FundManager.instance.getIndex = 2;
                  }
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
         uninitView();
         ObjectUtils.removeChildAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

