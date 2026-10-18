package apex.team
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.apex.ApexTeamData;
   import yishi.manager.ApexManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ApexTeamItem extends Sprite
   {
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var _btnTeamItemSign:IconButton;
      
      private var _btnTeamItemInvite:IconButton;
      
      private var _btnTeamItemQuit:IconButton;
      
      private var _txtTeamItemMyteam:FilterFrameText;
      
      private var _txtTeamItemNo:FilterFrameText;
      
      private var _data:ApexTeamData;
      
      private var members:Array;
      
      public function ApexTeamItem(param1:ApexTeamData)
      {
         super();
         this._data = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:ApexTeamPlayerItem = null;
         var _loc1_:int = 0;
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.apex.team.bg2");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.apex.team.bg1");
         _btnTeamItemSign = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnTeamItemSign");
         _btnTeamItemInvite = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnTeamItemInvite");
         _btnTeamItemQuit = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnTeamItemQuit");
         _txtTeamItemMyteam = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtTeamItemMyteam");
         _txtTeamItemNo = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtTeamItemNo");
         addChild(_bit0);
         addChild(_bit1);
         addChild(_btnTeamItemSign);
         addChild(_btnTeamItemInvite);
         addChild(_btnTeamItemQuit);
         addChild(_txtTeamItemMyteam);
         addChild(_txtTeamItemNo);
         _txtTeamItemMyteam.text = LanguageMgr.GetTranslation("apex.team.str3");
         _txtTeamItemNo.text = LanguageMgr.GetTranslation("apex.team.str4",_data.teamId);
         members = [];
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = new ApexTeamPlayerItem(_data.getMemberByIndex(_loc1_),_data);
            addChild(_loc2_);
            _loc2_.x = 136 + _loc1_ * 136;
            _loc2_.y = 4;
            members.push(_loc2_);
            _loc1_++;
         }
         if(_data.isSelfTeam)
         {
            _bit0.visible = false;
            _bit1.visible = true;
            _btnTeamItemInvite.visible = true;
            _btnTeamItemQuit.visible = true;
            _btnTeamItemSign.visible = true;
            _txtTeamItemMyteam.visible = true;
            _btnTeamItemSign.enable = ApexManager.instance.model.myTeamPlayer.isCaptain;
         }
         else
         {
            _bit0.visible = true;
            _bit1.visible = false;
            _btnTeamItemInvite.visible = false;
            _btnTeamItemQuit.visible = false;
            _btnTeamItemSign.visible = false;
            _txtTeamItemMyteam.visible = false;
         }
      }
      
      private function addEvent() : void
      {
         _btnTeamItemInvite.addEventListener("click",onClickInvite);
         _btnTeamItemQuit.addEventListener("click",onClickQuit);
         _btnTeamItemSign.addEventListener("click",onClickSign);
      }
      
      private function removeEvent() : void
      {
         _btnTeamItemInvite.removeEventListener("click",onClickInvite);
         _btnTeamItemQuit.removeEventListener("click",onClickQuit);
         _btnTeamItemSign.removeEventListener("click",onClickSign);
      }
      
      private function onClickSign(param1:MouseEvent) : void
      {
         if(!ApexManager.instance.model.myTeamPlayer.isCaptain)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("apex.hall.notCaptain"));
            return;
         }
         if(ApexManager.instance.model.isSign)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("apex.team.str8"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("apex.hall.hint");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [signConfirm];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,false,false,false,1);
      }
      
      private function signConfirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            ApexManager.instance.sendSign();
         }
      }
      
      private function onClickQuit(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("apex.team.str5");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [quitConfirm];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,false,false,false,1);
      }
      
      private function quitConfirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            ApexManager.instance.sendQuitTeam();
         }
      }
      
      private function onClickInvite(param1:MouseEvent) : void
      {
         var _loc2_:ApexTeamInviteFrame = ComponentFactory.Instance.creatComponentByStylename("apex.teamInviteFrame");
         _loc2_.show();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         _loc1_ = 0;
         while(_loc1_ < members.length)
         {
            ObjectUtils.disposeObject(members[_loc1_]);
            members[_loc1_] = null;
            _loc1_++;
         }
         members = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_btnTeamItemSign);
         _btnTeamItemSign = null;
         ObjectUtils.disposeObject(_btnTeamItemInvite);
         _btnTeamItemInvite = null;
         ObjectUtils.disposeObject(_btnTeamItemQuit);
         _btnTeamItemQuit = null;
         ObjectUtils.disposeObject(_txtTeamItemMyteam);
         _txtTeamItemMyteam = null;
         ObjectUtils.disposeObject(_txtTeamItemNo);
         _txtTeamItemNo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

