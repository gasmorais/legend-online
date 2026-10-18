package colosseum.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChallengeManager;
   import mvc.controler.ColosseumControler;
   import mvc.controler.SortController;
   import mvc.module.colosseum.ColosseumModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   
   public class ChallengeTopView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _rankReward:Bitmap;
      
      private var _SoulTxt:FilterFrameText;
      
      private var _SoulImg:Image;
      
      private var _goldTxt:FilterFrameText;
      
      private var _goldImg:Bitmap;
      
      private var _getTimeImg:Bitmap;
      
      private var _getTimeTxt:FilterFrameText;
      
      private var _battleFieldBtn:IconButton;
      
      private var _rankBtn:IconButton;
      
      public function ChallengeTopView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.challenge.topviewBg");
         _rankReward = ComponentFactory.Instance.creatBitmap("asset.challenge.topviewReward");
         _SoulTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.rewardSoultxt");
         _SoulImg = ComponentFactory.Instance.creatComponentByStylename("colosseum.RewardSoulIcon");
         _goldImg = ComponentFactory.Instance.creatBitmap("asset.core.GoldIcon");
         _goldTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.rewardGoldtxt");
         _getTimeImg = ComponentFactory.Instance.creatBitmap("asset.challenge.topviewGetTime");
         _getTimeTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.getTimetxt");
         _battleFieldBtn = ComponentFactory.Instance.creatComponentByStylename("colosseum.rinkBtn");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("colosseum.battleFieldBtn");
         addChild(_bg);
         addChild(_rankReward);
         addChild(_SoulTxt);
         addChild(_SoulImg);
         _SoulImg.x = 256;
         _SoulImg.y = 49;
         addChild(_goldImg);
         _goldImg.x = 182;
         _goldImg.y = 51;
         addChild(_goldTxt);
         addChild(_getTimeImg);
         addChild(_getTimeTxt);
         addChild(_battleFieldBtn);
         addChild(_rankBtn);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("REFRESH_CHALLENGE",refreshView);
         _battleFieldBtn && _battleFieldBtn.addEventListener("click",__battleFieldBtnHandler);
         _rankBtn && _rankBtn.addEventListener("click",__rankBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _battleFieldBtn && _battleFieldBtn.removeEventListener("click",__battleFieldBtnHandler);
         _rankBtn && _rankBtn.removeEventListener("click",__rankBtnHandler);
         NotificationManager.instance.removeEventListener("REFRESH_CHALLENGE",refreshView);
      }
      
      private function __battleFieldBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.showRankFrame();
      }
      
      private function __rankBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.showEventFrame();
      }
      
      private function refreshView(param1:Event = null) : void
      {
         if(model)
         {
            _goldTxt.text = getTakeCount(model.currentRank).toString();
            _SoulTxt.text = getTakeCount(model.currentRank).toString();
            _getTimeTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumSelfView.rewardDateValueText",model.leftDay);
         }
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
         return ChallengeManager.instance.model;
      }
      
      private function get sortController() : SortController
      {
         return FrameControllerManager.instance.sortController;
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
      
      public function resize(param1:int, param2:int) : void
      {
         if((param1 - 415) / 2 < 315)
         {
            x = 315;
         }
         else
         {
            this.x = (param1 - 415) / 2;
         }
         this.y = 2;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_rankReward);
         _rankReward = null;
         ObjectUtils.disposeObject(_SoulTxt);
         _SoulTxt = null;
         ObjectUtils.disposeObject(_SoulImg);
         _SoulImg = null;
         ObjectUtils.disposeObject(_goldTxt);
         _goldTxt = null;
         ObjectUtils.disposeObject(_goldImg);
         _goldImg = null;
         ObjectUtils.disposeObject(_getTimeImg);
         _getTimeImg = null;
         ObjectUtils.disposeObject(_getTimeTxt);
         _getTimeTxt = null;
         ObjectUtils.disposeObject(_battleFieldBtn);
         _battleFieldBtn = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
      }
   }
}

