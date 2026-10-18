package colosseum.view
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.SortEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.ColosseumControler;
   import mvc.controler.SortController;
   import mvc.module.colosseum.ColosseumModel;
   import mvc.module.sort.SortData;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.StringHelper;
   
   public class ColosseumSelfView extends Sprite implements Disposeable
   {
      
      private var _back2:MutipleImage;
      
      private var _figure:ShowAvatar;
      
      private var _todayLeftCount1:ScaleFrameImage;
      
      private var _todayLeftCount2:Bitmap;
      
      private var _todayLeftCountValue:FilterFrameText;
      
      private var _selfRank:Bitmap;
      
      private var _selfRankValue:FilterFrameText;
      
      private var _rankReward:Bitmap;
      
      private var _rewardGoldValue:FilterFrameText;
      
      private var _rewardGoldIcon:Image;
      
      private var _rewardSoulValue:FilterFrameText;
      
      private var _rewardSoulIcon:Image;
      
      private var _rewardDate:Bitmap;
      
      private var _rewardDateValue:FilterFrameText;
      
      private var _heroRankBtn:IconButton;
      
      private var _reportBtn:IconButton;
      
      private var _appellIcon1:Bitmap;
      
      private var _appellIcon2:Bitmap;
      
      private var _appellIcon3:Bitmap;
      
      private var _appellIcon4:Bitmap;
      
      private var _appell1:Bitmap;
      
      private var _appell2:Bitmap;
      
      private var _appell3:Bitmap;
      
      private var _appell4:Bitmap;
      
      private var _appellTxt1:GradientText;
      
      private var _appellTxt2:GradientText;
      
      private var _appellTxt3:GradientText;
      
      private var _appellTxt4:GradientText;
      
      private var _appellPlayer1:String = "";
      
      private var _appellPlayer2:String = "";
      
      private var _appellPlayer3:String = "";
      
      private var _appellPlayer4:String = "";
      
      public function ColosseumSelfView()
      {
         super();
         initView();
         initData();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _back2 = ComponentFactory.Instance.creatComponentByStylename("colosseum.FrameBack3.MutipleImage");
         _figure = new ShowAvatar();
         _figure.x = 46;
         _figure.y = 102;
         _figure.mouseChildren = _figure.mouseEnabled = false;
         _todayLeftCount1 = ComponentFactory.Instance.creatComponentByStylename("colosseum.TodayCount1");
         _todayLeftCount2 = ComponentFactory.Instance.creatBitmap("asset.colosseum.TodayCount2");
         _todayLeftCountValue = ComponentFactory.Instance.creatComponentByStylename("colosseum.TodayCountValue");
         _selfRank = ComponentFactory.Instance.creatBitmap("asset.colosseum.SelfRank");
         _selfRankValue = ComponentFactory.Instance.creatComponentByStylename("colosseum.SelfRankValue");
         _rankReward = ComponentFactory.Instance.creatBitmap("asset.colosseum.RankRewardAsset");
         _rewardGoldValue = ComponentFactory.Instance.creatComponentByStylename("colosseum.RewardGoldValue");
         _rewardGoldIcon = ComponentFactory.Instance.creatComponentByStylename("colosseum.RewardGoldIcon");
         _rewardSoulValue = ComponentFactory.Instance.creatComponentByStylename("colosseum.RewardSoulValue");
         _rewardSoulIcon = ComponentFactory.Instance.creatComponentByStylename("colosseum.RewardSoulIcon");
         _rewardDate = ComponentFactory.Instance.creatBitmap("asset.colosseum.RecieveAsset");
         _rewardDateValue = ComponentFactory.Instance.creatComponentByStylename("colosseum.RewardDateValue");
         _heroRankBtn = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankBtn");
         _reportBtn = ComponentFactory.Instance.creatComponentByStylename("colosseum.ReportBtn");
         _appellIcon1 = ComponentFactory.Instance.creatBitmap("asset.colosseum.AppellIcon1");
         _appellIcon2 = ComponentFactory.Instance.creatBitmap("asset.colosseum.AppellIcon2");
         _appellIcon3 = ComponentFactory.Instance.creatBitmap("asset.colosseum.AppellIcon2");
         _appellIcon4 = ComponentFactory.Instance.creatBitmap("asset.colosseum.AppellIcon2");
         _appell1 = ComponentFactory.Instance.creatBitmap("asset.colosseum.Appell1");
         _appell2 = ComponentFactory.Instance.creatBitmap("asset.colosseum.Appell2");
         _appell3 = ComponentFactory.Instance.creatBitmap("asset.colosseum.Appell3");
         _appell4 = ComponentFactory.Instance.creatBitmap("asset.colosseum.Appell4");
         _appellTxt1 = ComponentFactory.Instance.creatComponentByStylename("colosseum.AppellTxt1");
         _appellTxt2 = ComponentFactory.Instance.creatComponentByStylename("colosseum.AppellTxt2");
         _appellTxt3 = ComponentFactory.Instance.creatComponentByStylename("colosseum.AppellTxt3");
         _appellTxt4 = ComponentFactory.Instance.creatComponentByStylename("colosseum.AppellTxt4");
         _todayLeftCount1.setFrame(1);
         addChild(_back2);
         addChild(_figure);
         addChild(_todayLeftCount1);
         addChild(_todayLeftCount2);
         addChild(_todayLeftCountValue);
         addChild(_selfRank);
         addChild(_selfRankValue);
         addChild(_rankReward);
         addChild(_rewardGoldValue);
         addChild(_rewardGoldIcon);
         addChild(_rewardSoulValue);
         addChild(_rewardSoulIcon);
         addChild(_rewardDate);
         addChild(_rewardDateValue);
         addChild(_heroRankBtn);
         addChild(_reportBtn);
         addChild(_appellIcon1);
         addChild(_appellIcon2);
         addChild(_appellIcon3);
         _appellIcon3.y = 46;
         addChild(_appellIcon4);
         _appellIcon4.y = 66;
         addChild(_appell1);
         addChild(_appell2);
         addChild(_appell3);
         addChild(_appell4);
         addChild(_appellTxt1);
         addChild(_appellTxt2);
         addChild(_appellTxt3);
         addChild(_appellTxt4);
      }
      
      private function initData() : void
      {
         var _loc1_:SortData = null;
         while(sortController.model.playerFightList.length > 0)
         {
            _loc1_ = sortController.model.playerFightList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         sortController.model.currentSelected = 2;
         sortController.loadData("fight.xml");
      }
      
      private function initEvent() : void
      {
         _heroRankBtn.addEventListener("click",__heroBtnClickHandler);
         _reportBtn.addEventListener("click",__reportHandler);
         sortController.model.addEventListener("SELECTE_LIST_CHANG",__listChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _heroRankBtn.removeEventListener("click",__heroBtnClickHandler);
         _reportBtn.removeEventListener("click",__reportHandler);
         sortController.model.removeEventListener("SELECTE_LIST_CHANG",__listChangeHandler);
      }
      
      private function __listChangeHandler(param1:SortEvent) : void
      {
         var _loc3_:int = 0;
         if(sortController.model.playerFightList.length > 0)
         {
            for each(var _loc2_:SortData in sortController.model.playerFightList)
            {
               if(StringHelper.isNullOrEmpty(_appellPlayer1))
               {
                  _appellPlayer1 = _loc2_.nikcName;
                  _loc3_++;
               }
               if(StringHelper.isNullOrEmpty(_appellPlayer2) && _loc2_.army.baseHero.templateInfo.Job == 3)
               {
                  _appellPlayer2 = _loc2_.nikcName;
                  _loc3_++;
               }
               else if(StringHelper.isNullOrEmpty(_appellPlayer3) && _loc2_.army.baseHero.templateInfo.Job == 1)
               {
                  _appellPlayer3 = _loc2_.nikcName;
                  _loc3_++;
               }
               else if(StringHelper.isNullOrEmpty(_appellPlayer4) && _loc2_.army.baseHero.templateInfo.Job == 2)
               {
                  _appellPlayer4 = _loc2_.nikcName;
                  _loc3_++;
               }
               if(_loc3_ >= 4)
               {
                  break;
               }
            }
         }
         _appellTxt1.text = _appellPlayer1;
         _appellTxt2.text = _appellPlayer2;
         _appellTxt3.text = _appellPlayer3;
         _appellTxt4.text = _appellPlayer4;
      }
      
      private function __reportHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.showEventFrame();
      }
      
      private function __heroBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.showRankFrame();
      }
      
      private function refreshView() : void
      {
         if(model.remainFreeCount > 0)
         {
            _todayLeftCount1.setFrame(1);
            _todayLeftCountValue.text = model.remainFreeCount.toString();
         }
         else
         {
            _todayLeftCount1.setFrame(2);
            _todayLeftCountValue.text = model.remainBuyCount.toString();
         }
         _selfRankValue.text = model.currentRank.toString();
         _rewardGoldValue.text = getTakeCount(model.currentRank).toString();
         _rewardSoulValue.text = getTakeCount(model.currentRank).toString();
         _rewardGoldIcon.x = _rewardGoldValue.x + _rewardGoldValue.textWidth + 5;
         _rewardSoulValue.x = _rewardGoldIcon.x + _rewardGoldIcon.width + 10;
         _rewardSoulIcon.x = _rewardSoulValue.x + _rewardSoulValue.textWidth;
         _rewardDateValue.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumSelfView.rewardDateValueText",model.leftDay);
         _figure.data = thaneInfo;
      }
      
      private function getTakeCount(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(param1 == 0)
         {
            _loc2_ = 0;
         }
         else if(param1 == 1)
         {
            _loc2_ = 800000;
         }
         else if(param1 == 2)
         {
            _loc2_ = 600000;
         }
         else if(param1 >= 3 && param1 <= 4)
         {
            _loc2_ = 600000;
            _loc4_ = 3;
            while(_loc4_ < 5)
            {
               _loc2_ -= 100000;
               if(param1 == _loc4_)
               {
                  break;
               }
               _loc4_++;
            }
         }
         else if(param1 >= 5 && param1 <= 11)
         {
            _loc2_ = 400000;
            _loc4_ = 5;
            while(_loc4_ < 12)
            {
               _loc2_ -= 10000;
               if(param1 == _loc4_)
               {
                  break;
               }
               _loc4_++;
            }
         }
         else if(param1 >= 12 && param1 <= 51)
         {
            _loc2_ = 330000;
            _loc4_ = 12;
            while(_loc4_ < 52)
            {
               _loc2_ -= 5000;
               if(param1 == _loc4_)
               {
                  break;
               }
               _loc4_++;
            }
         }
         else
         {
            _loc2_ = 130000;
            _loc3_ = (param1 - 51) * 100;
            _loc2_ -= _loc3_;
            _loc2_ = int(_loc2_ < 1000 ? 1000 : _loc2_);
         }
         return _loc2_;
      }
      
      private function get thaneInfo() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get control() : ColosseumControler
      {
         return FrameControllerManager.instance.colosseumControler;
      }
      
      private function get model() : ColosseumModel
      {
         return control.model;
      }
      
      private function get sortController() : SortController
      {
         return FrameControllerManager.instance.sortController;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_todayLeftCount1);
         _todayLeftCount1 = null;
         ObjectUtils.disposeObject(_todayLeftCount2);
         _todayLeftCount2 = null;
         ObjectUtils.disposeObject(_todayLeftCountValue);
         _todayLeftCountValue = null;
         ObjectUtils.disposeObject(_selfRank);
         _selfRank = null;
         ObjectUtils.disposeObject(_selfRankValue);
         _selfRankValue = null;
         ObjectUtils.disposeObject(_heroRankBtn);
         _heroRankBtn = null;
         ObjectUtils.disposeObject(_appellIcon1);
         _appellIcon1 = null;
         ObjectUtils.disposeObject(_appellIcon2);
         _appellIcon2 = null;
         ObjectUtils.disposeObject(_appellIcon3);
         _appellIcon3 = null;
         ObjectUtils.disposeObject(_appellIcon4);
         _appellIcon4 = null;
         ObjectUtils.disposeObject(_appell1);
         _appell1 = null;
         ObjectUtils.disposeObject(_appell2);
         _appell2 = null;
         ObjectUtils.disposeObject(_appell3);
         _appell3 = null;
         ObjectUtils.disposeObject(_appell4);
         _appell4 = null;
         ObjectUtils.disposeObject(_appellTxt1);
         _appellTxt1 = null;
         ObjectUtils.disposeObject(_appellTxt2);
         _appellTxt2 = null;
         ObjectUtils.disposeObject(_appellTxt3);
         _appellTxt3 = null;
         ObjectUtils.disposeObject(_appellTxt4);
         _appellTxt4 = null;
         ObjectUtils.disposeObject(_reportBtn);
         _reportBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

