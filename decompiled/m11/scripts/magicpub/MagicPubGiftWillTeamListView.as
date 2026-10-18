package magicpub
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.giftparty.GiftPartyMsg;
   import com.road.yishi.proto.giftparty.GiftPartyTeamInfoMsg;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.manager.MagicPubManager;
   import yishi.manager.NotificationManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MagicPubGiftWillTeamListView extends Sprite implements Disposeable
   {
      
      private var _teamView1:MagicPubGiftWillTeamView;
      
      private var _teamView2:MagicPubGiftWillTeamView;
      
      private var _teamView3:MagicPubGiftWillTeamView;
      
      private var _teamMsg:GiftPartyMsg;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _timer:Timer;
      
      public function MagicPubGiftWillTeamListView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _teamView1 = new MagicPubGiftWillTeamView();
         _teamView2 = new MagicPubGiftWillTeamView();
         _teamView3 = new MagicPubGiftWillTeamView();
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.SignUpPageBg");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.SignUpPageTxt");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.SignUpPrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.SignUpNextPageBtn");
         addChild(_teamView1);
         addChild(_teamView2);
         addChild(_teamView3);
         addChild(_pageBg);
         addChild(_pageNumTxt);
         addChild(_prePageBtn);
         addChild(_nextPageBtn);
         _teamView1.x = 30;
         _teamView1.y = 45;
         _teamView2.x = 30;
         _teamView2.y = 175;
         _teamView3.x = 30;
         _teamView3.y = 305;
         _pageNumTxt.text = "1/1";
         _timer = new Timer(5000);
         _timer.start();
      }
      
      private function initEvent() : void
      {
         _prePageBtn.addEventListener("click",__preHandler);
         _nextPageBtn.addEventListener("click",__nextHandler);
         NotificationManager.instance.addEventListener("MAGICPUB_PLAYER_LIST",__playerListHandler);
         _timer.addEventListener("timer",timerHandler);
      }
      
      private function removeEvent() : void
      {
         _prePageBtn.removeEventListener("click",__preHandler);
         _nextPageBtn.removeEventListener("click",__nextHandler);
         NotificationManager.instance.removeEventListener("MAGICPUB_PLAYER_LIST",__playerListHandler);
         _timer.removeEventListener("timer",timerHandler);
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         if(_teamMsg)
         {
            MagicPubManager.instance.OperateGiftParty(9,0,0,0,_teamMsg.pageIndex);
         }
         else
         {
            MagicPubManager.instance.OperateGiftParty(9,0,0,0,1);
         }
      }
      
      private function __playerListHandler(param1:NotificationEvent) : void
      {
         var _loc2_:GiftPartyTeamInfoMsg = null;
         var _loc3_:int = 0;
         _teamMsg = MagicPubManager.instance.teamMsg;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc2_ = _teamMsg.teamInfo[_loc3_];
            if(_loc2_)
            {
               this["_teamView" + (_loc3_ + 1)].data = _loc2_;
            }
            else
            {
               this["_teamView" + (_loc3_ + 1)].data = null;
            }
            _loc3_++;
         }
         _pageNumTxt.text = _teamMsg.pageIndex + "/" + _teamMsg.totalPage;
      }
      
      private function __preHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_teamMsg)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("magicpub.MagicPubListView.noOpen"));
            return;
         }
         MagicPubManager.instance.OperateGiftParty(9,0,0,0,_teamMsg.pageIndex - 1);
      }
      
      private function __nextHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_teamMsg)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("magicpub.MagicPubListView.noOpen"));
            return;
         }
         MagicPubManager.instance.OperateGiftParty(9,0,0,0,_teamMsg.pageIndex + 1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_teamView1);
         _teamView1 = null;
         ObjectUtils.disposeObject(_teamView2);
         _teamView2 = null;
         ObjectUtils.disposeObject(_teamView3);
         _teamView3 = null;
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         _teamMsg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_timer)
         {
            _timer.stop();
         }
         _timer = null;
      }
   }
}

