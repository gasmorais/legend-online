package petchallenge.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PetChallengeManager;
   import mvc.controler.PetChallengeController;
   import mvc.module.petchallenge.PetChallengeModel;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.NumberViewUtils;
   
   public class PetChallengeTeamView extends Component
   {
      
      private var back:MutipleImage;
      
      private var alertTxt:FilterFrameText;
      
      private var scoreContiner:Component;
      
      private var fightContiner:Component;
      
      private var numberBitmap:BitmapData;
      
      private var petItemList:Vector.<PetChallengeTeamItemView>;
      
      public function PetChallengeTeamView()
      {
         super();
         initView();
         initListView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("PetChallengeTeamView.back");
         alertTxt = ComponentFactory.Instance.creatComponentByStylename("PetChallengeTeamView.alertTxt");
         numberBitmap = ComponentFactory.Instance.creatBitmapData("asset.PetChallengeTeamView.scoreBitmap");
         scoreContiner = ComponentFactory.Instance.creatComponentByStylename("PetChallengeTeamView.scoreContiner");
         fightContiner = ComponentFactory.Instance.creatComponentByStylename("PetChallengeTeamView.fightContiner");
         addChild(back);
         addChild(alertTxt);
         addChild(scoreContiner);
         addChild(fightContiner);
         alertTxt.text = LanguageMgr.GetTranslation("PetChallengeTeamView.alertTxt.text");
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetChallengeTeamItemView = null;
         petItemList = new Vector.<PetChallengeTeamItemView>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new PetChallengeTeamItemView();
            addChild(_loc1_);
            _loc1_.y = (_loc2_ + 1) * 55 - 2;
            _loc1_.x = 80;
            petItemList[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         model.addEventListener(PetChallengeModel.CHALLENGE_INFO_CHAGNE,__refreshHandler);
         playerInfo.addEventListener("PLAYER_PET_LIST_CHANGE",__petformationChangeHandler);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener(PetChallengeModel.CHALLENGE_INFO_CHAGNE,__refreshHandler);
         playerInfo.removeEventListener("PLAYER_PET_LIST_CHANGE",__petformationChangeHandler);
      }
      
      private function __petformationChangeHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function __refreshHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         NumberViewUtils.refreshValue(model.totalResiScore,scoreContiner,numberBitmap,19,25,16,19,"0123456789");
         NumberViewUtils.refreshValue(model.selfInfo.totalFightPower,fightContiner,numberBitmap,19,25,16,19,"0123456789");
         _loc1_ = 0;
         while(_loc1_ < petItemList.length)
         {
            petItemList[_loc1_].data = model.getPetChallengeTeamList()[_loc1_];
            _loc1_++;
         }
      }
      
      private function __openFormationHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.openFormationFrame();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : PetChallengeModel
      {
         return PetChallengeManager.instance.model;
      }
      
      private function get control() : PetChallengeController
      {
         return FrameControllerManager.instance.petchallengeController;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(alertTxt);
         alertTxt = null;
         ObjectUtils.disposeObject(scoreContiner);
         scoreContiner = null;
         ObjectUtils.disposeObject(fightContiner);
         fightContiner = null;
         ObjectUtils.disposeObject(numberBitmap);
         numberBitmap = null;
         LogicUtils.disposeDisplayCollection(petItemList);
         petItemList = null;
         super.dispose();
      }
   }
}

