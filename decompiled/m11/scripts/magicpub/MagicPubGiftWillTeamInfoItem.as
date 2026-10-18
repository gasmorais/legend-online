package magicpub
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.giftparty.TeamMemberInfoMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.MagicPubControler;
   import yishi.manager.MagicPubManager;
   import yishi.manager.PlayerManager;
   
   public class MagicPubGiftWillTeamInfoItem extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _selectBit:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _startBtn:IconButton;
      
      private var _tiBtn:IconButton;
      
      private var _readyBtn:IconButton;
      
      private var _readyTxt:FilterFrameText;
      
      private var _noReadyTxt:FilterFrameText;
      
      private var _goodGradeName:MagicPubGiftWillGradeView;
      
      private var _teamId:int;
      
      private var _masterUserId:int;
      
      private var _isMasterSelf:Boolean;
      
      private var _data:TeamMemberInfoMsg;
      
      public function MagicPubGiftWillTeamInfoItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.magicpub.giftWill.teamInfoBack");
         _selectBit = ComponentFactory.Instance.creatBitmap("asset.magicpub.giftWill.teamInfoSelect");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.teamPlayerNameTxt");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.startBtn");
         _tiBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.tiBtn");
         _readyBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.readyBtn");
         _readyTxt = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.readyTxt");
         _noReadyTxt = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.noReadyTxt");
         _goodGradeName = new MagicPubGiftWillGradeView();
         addChild(_back);
         addChild(_selectBit);
         addChild(_nameTxt);
         addChild(_startBtn);
         addChild(_tiBtn);
         addChild(_readyBtn);
         addChild(_readyTxt);
         addChild(_noReadyTxt);
         addChild(_goodGradeName);
         _goodGradeName.x = 115;
         _goodGradeName.y = 18;
         _noReadyTxt.text = LanguageMgr.GetTranslation("magicpub.MagicPubGiftWillTeamInfoItem.noReadyTxt");
         _readyTxt.text = LanguageMgr.GetTranslation("magicpub.MagicPubGiftWillTeamInfoItem.readyTxt");
      }
      
      private function initEvent() : void
      {
         _startBtn.addEventListener("click",__startHandler);
         _tiBtn.addEventListener("click",__tiHandler);
         _readyBtn.addEventListener("click",__readyHandler);
      }
      
      private function removeEvent() : void
      {
         _startBtn.removeEventListener("click",__startHandler);
         _tiBtn.removeEventListener("click",__tiHandler);
         _readyBtn.removeEventListener("click",__readyHandler);
      }
      
      public function set isMaster(param1:Boolean) : void
      {
         _isMasterSelf = param1;
      }
      
      public function set masterUserId(param1:int) : void
      {
         _masterUserId = param1;
      }
      
      public function set teamId(param1:int) : void
      {
         _teamId = param1;
      }
      
      public function set data(param1:TeamMemberInfoMsg) : void
      {
         _data = param1;
         clearView();
         if(!param1)
         {
            return;
         }
         _nameTxt.visible = true;
         _goodGradeName.visible = true;
         _selectBit.visible = _data.placeState == 1 || _data.placeState == 2;
         _nameTxt.text = _data.nickName;
         _goodGradeName.setDataGradeAndPos(_data.fragQuality,_data.fragLevel);
         if(_isMasterSelf)
         {
            if(_masterUserId == _data.userId)
            {
               _startBtn.visible = true;
               _startBtn.enable = true;
            }
            else
            {
               _readyTxt.visible = _data.placeState == 1;
               _noReadyTxt.visible = _data.placeState == 0;
               _tiBtn.visible = true;
            }
            _readyTxt.y = 1;
            _noReadyTxt.y = 1;
         }
         else if(_masterUserId == _data.userId)
         {
            _startBtn.visible = true;
            _startBtn.enable = false;
         }
         else
         {
            _readyBtn.visible = _data.placeState == 0 && PlayerManager.instance.currentPlayerModel.playerInfo.userId == _data.userId;
            _readyTxt.visible = _data.placeState == 1;
            _noReadyTxt.visible = _data.placeState == 0 && PlayerManager.instance.currentPlayerModel.playerInfo.userId != _data.userId;
         }
      }
      
      private function __startHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         MagicPubManager.instance.OperateGiftParty(5);
         MagicPubControler.needRefresh = true;
      }
      
      private function __tiHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         MagicPubManager.instance.OperateGiftParty(4,0,_data.userId);
         MagicPubControler.needRefresh = true;
      }
      
      private function __readyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         MagicPubManager.instance.OperateGiftParty(3,0,0,1);
      }
      
      private function clearView() : void
      {
         _selectBit.visible = false;
         _nameTxt.visible = false;
         _startBtn.visible = false;
         _tiBtn.visible = false;
         _readyBtn.visible = false;
         _readyTxt.visible = false;
         _noReadyTxt.visible = false;
         _goodGradeName.visible = false;
         _readyTxt.y = 17;
         _noReadyTxt.y = 17;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_selectBit);
         _selectBit = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_tiBtn);
         _tiBtn = null;
         ObjectUtils.disposeObject(_readyBtn);
         _readyBtn = null;
         ObjectUtils.disposeObject(_readyTxt);
         _readyTxt = null;
         ObjectUtils.disposeObject(_noReadyTxt);
         _noReadyTxt = null;
         ObjectUtils.disposeObject(_goodGradeName);
         _goodGradeName = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

