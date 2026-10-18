package newyearactivity
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.active.ItemMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.NewYearSocketOutManager;
   import newyearact.ContinousLoginModel;
   import newyearact.ContinousLoginRewardInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.NewYearActManager;
   import yishi.view.community.BaseItemView;
   
   public class ContinuousLoginItem extends Sprite implements Disposeable
   {
      
      private var _model:ContinousLoginModel;
      
      private var _rewardList:Array;
      
      private var _data:ContinousLoginRewardInfo;
      
      private var _loginDay:FilterFrameText;
      
      private var _hbox:HBox;
      
      private var _getRewardBtn:BaseButton;
      
      private var _hasGetRewardImg:Bitmap;
      
      public function ContinuousLoginItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _model = NewYearActManager.instance.loginModel;
         _loginDay = ComponentFactory.Instance.creatComponentByStylename("newYearAct.continuousLogin.loginDayTxt");
         _hbox = new HBox();
         _getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("newYearAct.getRewardBtn");
         _hasGetRewardImg = ComponentFactory.Instance.creatBitmap("asset.newYearAct.hasGetRewardImg");
         addChild(_loginDay);
         addChild(_hbox);
         _hbox.x = 110;
         _hbox.y = 7;
         _hbox.spacing = 4;
         addChild(_getRewardBtn);
         addChild(_hasGetRewardImg);
         _hasGetRewardImg.visible = false;
      }
      
      private function initEvent() : void
      {
         _getRewardBtn.addEventListener("click",__getRewardBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _getRewardBtn.removeEventListener("click",__getRewardBtnHandler);
      }
      
      private function initData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc3_:GoodsInfo = null;
         _hbox.removeAllChild();
         _loc2_ = 0;
         while(_loc2_ < _rewardList.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("newyearact.rewardItem");
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = (_rewardList[_loc2_] as ItemMsg).itemTempId;
            _loc3_.count = (_rewardList[_loc2_] as ItemMsg).count;
            _loc1_.data = _loc3_;
            _hbox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      public function set data(param1:ContinousLoginRewardInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         if(NewYearActManager.instance.loginRewardList && NewYearActManager.instance.loginRewardList.length >= _data.index)
         {
            _rewardList = NewYearActManager.instance.loginRewardList[_data.index - 1];
            initData();
         }
         _loginDay.htmlText = LanguageMgr.GetTranslation("newyearactivity.ContinuousLoginItem.day",_data.index);
         if(_data.index > _model.loginNum)
         {
            _hasGetRewardImg.visible = false;
            _getRewardBtn.visible = true;
            _getRewardBtn.enable = false;
            setFilter(false);
         }
         else if(_data.status == 1)
         {
            _hasGetRewardImg.visible = true;
            _getRewardBtn.visible = false;
            _getRewardBtn.enable = false;
            setFilter(true);
         }
         else
         {
            _hasGetRewardImg.visible = false;
            _getRewardBtn.visible = true;
            _getRewardBtn.enable = true;
            setFilter(false);
         }
      }
      
      private function __getRewardBtnHandler(param1:MouseEvent) : void
      {
         NewYearSocketOutManager.sendGetReward(1,_data.index);
      }
      
      private function setFilter(param1:Boolean) : void
      {
         if(param1)
         {
            _hbox.filters = [UIFilter.getBlackFilter()];
         }
         else
         {
            _hbox.filters = [];
         }
      }
      
      public function dispose() : void
      {
         _data = null;
         removeEvent();
         ObjectUtils.disposeObject(_loginDay);
         _hbox.disposeAllChildren();
         if(_hbox)
         {
            ObjectUtils.disposeObject(_hbox);
         }
         _hbox = null;
         ObjectUtils.disposeObject(_getRewardBtn);
         _getRewardBtn = null;
      }
   }
}

