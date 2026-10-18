package gamebox.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import gamebox.vo.GameBoxGameVO;
   import manager.LanguageMgr;
   import managers.GameBoxManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class GameBoxItemView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _gameNameImg:Bitmap;
      
      private var _rewardImg:Bitmap;
      
      private var _smallImg:Bitmap;
      
      private var _starBtn:BaseButton;
      
      private var _leftImg:Bitmap;
      
      private var _rightImg:Bitmap;
      
      private var _cfgData:GameBoxGameVO;
      
      private var _openDayTxt:FilterFrameText;
      
      private var _openAlertTxt:FilterFrameText;
      
      private var _itemIconArr:Array;
      
      private var DAY_LANGUAGE:Array = ["public.Sunday","public.Monday","public.Tuesday","public.Wednesday","public.Thursday","public.Friday","public.Saturday"];
      
      public function GameBoxItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get cfgData() : GameBoxGameVO
      {
         return _cfgData;
      }
      
      public function set cfgData(param1:GameBoxGameVO) : void
      {
         _cfgData = param1;
         updateView();
         try
         {
            _smallImg = ComponentFactory.Instance.creatBitmap("asset.gamebox.gameImg" + _cfgData.gameId);
            addChild(_smallImg);
         }
         catch(e:Error)
         {
         }
      }
      
      public function updateView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc3_:GoodsInfo = null;
         if(_gameNameImg == null)
         {
            _gameNameImg = ComponentFactory.Instance.creatBitmap("asset.gamebox.gameName" + _cfgData.gameId);
            addChild(_gameNameImg);
         }
         _openAlertTxt.text = LanguageMgr.GetTranslation("gamebox.view.openAlertTxt.text");
         _openAlertTxt.visible = _openDayTxt.visible = _starBtn.visible = false;
         if(checkIsTodayOpen(-1))
         {
            _starBtn.visible = true;
         }
         else if(checkIsTodayOpen(PlayerManager.instance.currentPlayerModel.sysCurtime.day))
         {
            _starBtn.visible = true;
         }
         else
         {
            _openAlertTxt.visible = true;
            _openDayTxt.visible = true;
         }
         var _loc4_:String = "";
         _loc2_ = 0;
         while(_loc2_ < cfgData.openDay.length)
         {
            if(cfgData.openDay[_loc2_] != -1)
            {
               _loc4_ += LanguageMgr.GetTranslation(DAY_LANGUAGE[_cfgData.openDay[_loc2_]]) + ",";
            }
            _loc2_++;
         }
         _openDayTxt.text = _loc4_.substring(0,_loc4_.lastIndexOf(","));
         _loc2_ = 0;
         while(_loc2_ < cfgData.rewards.length)
         {
            _loc1_ = _itemIconArr[_loc2_];
            if(_loc1_ == null)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("gamebox.GameRewardItemView" + _loc2_);
               addChild(_loc1_);
               _itemIconArr.push(_loc1_);
               _loc3_ = new GoodsInfo();
               _loc3_.templateId = cfgData.rewards[_loc2_];
               _loc1_.data = _loc3_;
            }
            _loc2_++;
         }
      }
      
      private function checkIsTodayOpen(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < cfgData.openDay.length)
         {
            if(cfgData.openDay[_loc2_] == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function initView() : void
      {
         _itemIconArr = [];
         _bg = ComponentFactory.Instance.creatBitmap("asset.gamebox.gameboxitemBg");
         _rewardImg = ComponentFactory.Instance.creatBitmap("asset.gamebox.gameboxitemRewardImg");
         _starBtn = ComponentFactory.Instance.creatComponentByStylename("gamebox.gameitem.starBtn");
         _leftImg = ComponentFactory.Instance.creatBitmap("asset.gamebox.gameItemLeft");
         _rightImg = ComponentFactory.Instance.creatBitmap("asset.gamebox.gameItemRight");
         _openDayTxt = ComponentFactory.Instance.creatComponentByStylename("gamebox.gameOpenDayTxt");
         _openAlertTxt = ComponentFactory.Instance.creatComponentByStylename("gamebox.openAlertTxt");
         addChild(_bg);
         addChild(_rewardImg);
         addChild(_starBtn);
         addChild(_leftImg);
         addChild(_rightImg);
         addChild(_openAlertTxt);
         addChild(_openDayTxt);
      }
      
      public function addEvent() : void
      {
         _starBtn.addEventListener("click",onStarBtnClick);
      }
      
      public function removeEvent() : void
      {
         if(_starBtn)
         {
            _starBtn.removeEventListener("click",onStarBtnClick);
         }
      }
      
      private function onStarBtnClick(param1:MouseEvent) : void
      {
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip06"));
            return;
         }
         GameBoxManager.instance.starGame(_cfgData.gameId);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_gameNameImg);
         _gameNameImg = null;
         ObjectUtils.disposeObject(_rewardImg);
         _rewardImg = null;
         ObjectUtils.disposeObject(_starBtn);
         _starBtn = null;
         ObjectUtils.disposeObject(_openDayTxt);
         _openDayTxt = null;
         ObjectUtils.disposeObject(_openAlertTxt);
         _openAlertTxt = null;
         ObjectUtils.disposeObject(_smallImg);
         _smallImg = null;
         if(_itemIconArr != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _itemIconArr.length)
            {
               ObjectUtils.disposeObject(_itemIconArr[_loc1_]);
               _itemIconArr[_loc1_] = null;
               _loc1_++;
            }
            _itemIconArr = null;
         }
         DAY_LANGUAGE = null;
         super.dispose();
      }
   }
}

