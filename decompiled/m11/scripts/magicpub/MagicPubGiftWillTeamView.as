package magicpub
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.giftparty.GiftPartyMsg;
   import com.road.yishi.proto.giftparty.GiftPartyTeamInfoMsg;
   import com.road.yishi.proto.giftparty.TeamMemberInfoMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.controler.MagicPubControler;
   import yishi.manager.MagicPubManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class MagicPubGiftWillTeamView extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _item1:MagicPubGiftWillTeamItem;
      
      private var _item2:MagicPubGiftWillTeamItem;
      
      private var _item3:MagicPubGiftWillTeamItem;
      
      private var _addTeamBtn:IconButton;
      
      private var _data:GiftPartyTeamInfoMsg;
      
      public function MagicPubGiftWillTeamView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.magicpub.giftWill.teamBagBack");
         _item1 = new MagicPubGiftWillTeamItem();
         _item2 = new MagicPubGiftWillTeamItem();
         _item3 = new MagicPubGiftWillTeamItem();
         _addTeamBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.addTeamBtn");
         addChild(_back);
         addChild(_item1);
         addChild(_item2);
         addChild(_item3);
         addChild(_addTeamBtn);
         _item1.x = 25;
         _item1.y = 18;
         _item2.x = 140;
         _item2.y = 18;
         _item3.x = 255;
         _item3.y = 18;
      }
      
      private function initEvent() : void
      {
         _addTeamBtn.addEventListener("click",__addTeamHandler);
      }
      
      private function removeEvent() : void
      {
         _addTeamBtn.removeEventListener("click",__addTeamHandler);
      }
      
      public function set data(param1:GiftPartyTeamInfoMsg) : void
      {
         var _loc3_:TeamMemberInfoMsg = null;
         var _loc2_:int = 0;
         _data = param1;
         clearView();
         if(!_data)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _data.memberInfo.length)
         {
            _loc3_ = _data.memberInfo[_loc2_];
            if(_loc3_)
            {
               this["_item" + _loc3_.fragLevel].teamId = _data.teamId;
               this["_item" + _loc3_.fragLevel].data = _loc3_;
            }
            _loc2_++;
         }
         _addTeamBtn.visible = true;
      }
      
      private function __addTeamHandler(param1:Event = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         SoundManager.instance.play("022");
         if(!_data)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("magicpub.MagicPubListView.noOpen"));
            return;
         }
         var _loc4_:GiftPartyMsg = MagicPubManager.instance.partyMsg;
         if(_loc4_ && _loc4_.partyCount <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("MagicPub.noReward.tip");
            SimpleAlertHelper.instance.data = [__alertResponse];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,false,true);
         }
         else
         {
            sendAdd();
         }
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean = false) : void
      {
         if(param1)
         {
            sendAdd();
         }
      }
      
      private function sendAdd() : void
      {
         MagicPubManager.instance.OperateGiftParty(1,_data.teamId);
         MagicPubControler.needRefresh = true;
      }
      
      private function clearView() : void
      {
         _item1.data = null;
         _item2.data = null;
         _item3.data = null;
         _addTeamBtn.visible = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_item1);
         _item1 = null;
         ObjectUtils.disposeObject(_item2);
         _item2 = null;
         ObjectUtils.disposeObject(_item3);
         _item3 = null;
         ObjectUtils.disposeObject(_addTeamBtn);
         _addTeamBtn = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

