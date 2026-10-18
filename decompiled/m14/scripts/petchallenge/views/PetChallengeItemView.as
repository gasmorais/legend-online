package petchallenge.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PetChallengeManager;
   import mvc.module.petchallenge.PetChallengeModel;
   import mvc.module.petchallenge.PetChallengeObjectData;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PetChallengeItemView extends Component
   {
      
      private var back:Bitmap;
      
      private var rankNumText:GradientText;
      
      private var headHbox:HBox;
      
      private var nameAndServer:FilterFrameText;
      
      private var fightImage:Image;
      
      private var fightText:FilterFrameText;
      
      private var scoreText:FilterFrameText;
      
      private var groupIcon:ScaleFrameImage;
      
      private var challengeBtn:IconButton;
      
      private var resultImage:ScaleFrameImage;
      
      private var headList:Vector.<PetChallengeHeadItem>;
      
      private var groupId:int;
      
      private var _data:PetChallengeObjectData;
      
      public function PetChallengeItemView()
      {
         super();
         initView();
         initPetListView();
         addEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatBitmap("asset.PetChallengeItemView.back");
         headHbox = ComponentFactory.Instance.creatComponentByStylename("PetChallengeItemView.headHbox");
         nameAndServer = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortItem.nameAndServer");
         fightImage = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortItem.fightImage");
         fightText = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortItem.fightText");
         groupIcon = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortItem.groupIcon");
         scoreText = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortItem.scoreText");
         challengeBtn = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortItem.challengeBtn");
         resultImage = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortItem.resultImage");
         addChild(back);
         addChild(headHbox);
         addChild(nameAndServer);
         addChild(fightImage);
         addChild(fightText);
         addChild(scoreText);
         addChild(groupIcon);
         groupIcon.setFrame(1);
         addChild(challengeBtn);
         addChild(resultImage);
         resultImage.setFrame(1);
         clean();
      }
      
      private function initPetListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetChallengeHeadItem = null;
         headList = new Vector.<PetChallengeHeadItem>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new PetChallengeHeadItem();
            headHbox.addChild(_loc1_);
            headList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         challengeBtn.addEventListener("click",__onChallengeHandler);
      }
      
      private function removeEvent() : void
      {
         if(challengeBtn)
         {
            challengeBtn.removeEventListener("click",__onChallengeHandler);
         }
      }
      
      private function __onChallengeHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         if(model.buildingOrder.remainTime > 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("colosseum.view.ColosseumListView.command02"));
            return;
         }
         if(playerInfo.petChallengeCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetChallengeController.nochallengepet"));
            return;
         }
         if(model.buildingOrder.remainCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("godarrive.GodArriveFrame.NoLeftCount"));
            return;
         }
         PetChallengeManager.instance.sendChallengeCommand(data.uuid);
      }
      
      public function get data() : PetChallengeObjectData
      {
         return _data;
      }
      
      public function set data(param1:PetChallengeObjectData) : void
      {
         clean();
         _data = param1;
         if(_data)
         {
            refreshView();
         }
      }
      
      private function clean() : void
      {
         groupIcon.visible = false;
         fightImage.visible = false;
         challengeBtn.visible = false;
         resultImage.visible = false;
         headHbox.visible = false;
         nameAndServer.text = "";
         fightText.text = "";
         scoreText.text = "";
         if(rankNumText)
         {
            ObjectUtils.disposeObject(rankNumText);
         }
         rankNumText = null;
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         if(model.curSelectIndex == 0)
         {
            headHbox.x = 73;
            headHbox.y = 10;
            headHbox.spacing = 8;
            groupIcon.visible = true;
            if(data.ranking > 3)
            {
               rankNumText = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortItem.rankNumText4");
            }
            else
            {
               rankNumText = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSortItem.rankNumText" + data.ranking);
            }
            rankNumText.text = LanguageMgr.GetTranslation("PetChallengeSortItem.rankNumText.text",data.ranking);
            if(!rankNumText.parent)
            {
               addChild(rankNumText);
            }
            rankNumText.x = 5;
         }
         else if(model.curSelectIndex == 1)
         {
            headHbox.x = 20;
            headHbox.y = 5;
            headHbox.spacing = 25;
            challengeBtn.visible = true;
         }
         else
         {
            headHbox.x = 20;
            headHbox.y = 5;
            headHbox.spacing = 25;
            resultImage.visible = true;
         }
         headHbox.visible = true;
         fightImage.visible = true;
         groupId = model.getGroupIdByRankAndScore(data.ranking,data.score);
         nameAndServer.text = data.userName + "-" + data.serverName;
         fightText.text = data.totalFightPower.toString();
         groupIcon.setFrame(groupId);
         scoreText.text = LanguageMgr.GetTranslation("PetChallengeSortItem.scoreText.text",data.score);
         data.result == 1 ? resultImage.setFrame(1) : resultImage.setFrame(2);
         _loc1_ = 0;
         while(_loc1_ < headList.length)
         {
            headList[_loc1_].data = _loc1_ >= data.petList.length ? null : data.petList[_loc1_];
            _loc1_++;
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : PetChallengeModel
      {
         return PetChallengeManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(headHbox);
         headHbox = null;
         ObjectUtils.disposeObject(rankNumText);
         rankNumText = null;
         ObjectUtils.disposeObject(nameAndServer);
         nameAndServer = null;
         ObjectUtils.disposeObject(fightImage);
         fightImage = null;
         ObjectUtils.disposeObject(fightText);
         fightText = null;
         ObjectUtils.disposeObject(groupIcon);
         groupIcon = null;
         ObjectUtils.disposeObject(scoreText);
         scoreText = null;
         ObjectUtils.disposeObject(challengeBtn);
         challengeBtn = null;
         ObjectUtils.disposeObject(resultImage);
         resultImage = null;
         LogicUtils.disposeDisplayCollection(headList);
         headList = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

