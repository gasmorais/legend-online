package apex.team
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.apex.ApexTeamData;
   import mvc.module.apex.ApexTeamMemberData;
   import yishi.manager.ApexManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class ApexTeamPlayerItem extends Sprite
   {
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var _bit2:Bitmap;
      
      private var _bit3:Bitmap;
      
      private var _txtTeamPlayerItemName:FilterFrameText;
      
      private var _txtTeamPlayerItemConsortia:FilterFrameText;
      
      private var _btnTeamPlayerItemClose:BaseButton;
      
      private var _txtTeamPlayerItemLv:FilterFrameText;
      
      private var _txtTeamPlayerItemFP:FilterFrameText;
      
      private var _btnTeamPlayerItemAdd:BaseButton;
      
      private var _data:ApexTeamMemberData;
      
      private var _teamData:ApexTeamData;
      
      private var _icon:BaseIconView;
      
      private var _imgJob:ScaleFrameImage;
      
      public function ApexTeamPlayerItem(param1:ApexTeamMemberData, param2:ApexTeamData)
      {
         super();
         this._data = param1;
         this._teamData = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.apex.team.itemBg");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.apex.team.img1");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.apex.team.flag");
         _bit3 = ComponentFactory.Instance.creatBitmap("asset.apex.team.img2");
         _txtTeamPlayerItemName = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtTeamPlayerItemName");
         _txtTeamPlayerItemConsortia = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtTeamPlayerItemConsortia");
         _btnTeamPlayerItemClose = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnTeamPlayerItemClose");
         _txtTeamPlayerItemLv = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtTeamPlayerItemLv");
         _txtTeamPlayerItemFP = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtTeamPlayerItemFP");
         _btnTeamPlayerItemAdd = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnTeamPlayerItemAdd");
         _icon = ComponentFactory.Instance.creatCustomObject("aped.apexTeamPlayer.icon");
         _imgJob = ComponentFactory.Instance.creatComponentByStylename("apex.JobChangeBtn");
         addChild(_bit0);
         addChild(_bit1);
         addChild(_icon);
         addChild(_bit2);
         addChild(_bit3);
         addChild(_txtTeamPlayerItemName);
         addChild(_txtTeamPlayerItemConsortia);
         addChild(_btnTeamPlayerItemClose);
         addChild(_txtTeamPlayerItemLv);
         addChild(_txtTeamPlayerItemFP);
         addChild(_btnTeamPlayerItemAdd);
         addChild(_imgJob);
         _imgJob.scaleX = _imgJob.scaleY = 0.6;
         if(_data)
         {
            _txtTeamPlayerItemLv.text = (_data.level >> 16 & 0xFFFF) + "";
            _imgJob.setFrame(_data.level & 0xFFFF);
            _txtTeamPlayerItemName.text = _data.nickName;
            _txtTeamPlayerItemFP.text = _data.fightPower + "";
            if(_data.guildName)
            {
               _txtTeamPlayerItemConsortia.text = "<" + _data.guildName + ">";
            }
            else
            {
               _txtTeamPlayerItemConsortia.text = "";
            }
            _bit2.visible = _data.isCaptain;
            _bit1.visible = true;
            _bit3.visible = true;
            _imgJob.visible = true;
            _btnTeamPlayerItemAdd.visible = false;
            _icon.icon = IconFactory.getPlayerIcon(_data.headPics,"head");
            if(m.model.myTeamPlayer && m.model.myTeamPlayer.isCaptain && _teamData.isSelfTeam && !_data.isCaptain)
            {
               _btnTeamPlayerItemClose.visible = true;
            }
            else
            {
               _btnTeamPlayerItemClose.visible = false;
            }
         }
         else
         {
            _bit1.visible = false;
            _bit2.visible = false;
            _bit3.visible = false;
            _imgJob.visible = false;
            _btnTeamPlayerItemAdd.visible = true;
            _btnTeamPlayerItemClose.visible = false;
         }
      }
      
      private function addEvent() : void
      {
         _btnTeamPlayerItemAdd.addEventListener("click",onClickAdd);
         _btnTeamPlayerItemClose.addEventListener("click",onClickKick);
      }
      
      private function removeEvent() : void
      {
         _btnTeamPlayerItemAdd.removeEventListener("click",onClickAdd);
         _btnTeamPlayerItemClose.removeEventListener("click",onClickKick);
      }
      
      private function onClickKick(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("apex.team.str6",_data.nickName);
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [kickConfirm];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,false,false,false,1);
      }
      
      private function kickConfirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            m.sendKickTeammate(_data.userId);
         }
      }
      
      private function onClickAdd(param1:MouseEvent) : void
      {
         if(!m.model.myTeamPlayer)
         {
            addConfirm(true,true);
            return;
         }
         if(_teamData.teamId == m.model.myTeamPlayer.teamId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("apex.team.str10"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("apex.team.str7");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [addConfirm];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,false,false,false,1);
      }
      
      private function addConfirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            m.sendJoinTeam(_teamData.teamId);
         }
      }
      
      public function get m() : ApexManager
      {
         return ApexManager.instance;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_bit3);
         _bit3 = null;
         ObjectUtils.disposeObject(_txtTeamPlayerItemName);
         _txtTeamPlayerItemName = null;
         ObjectUtils.disposeObject(_txtTeamPlayerItemConsortia);
         _txtTeamPlayerItemConsortia = null;
         ObjectUtils.disposeObject(_btnTeamPlayerItemClose);
         _btnTeamPlayerItemClose = null;
         ObjectUtils.disposeObject(_txtTeamPlayerItemLv);
         _txtTeamPlayerItemLv = null;
         ObjectUtils.disposeObject(_txtTeamPlayerItemFP);
         _txtTeamPlayerItemFP = null;
         ObjectUtils.disposeObject(_btnTeamPlayerItemAdd);
         _btnTeamPlayerItemAdd = null;
         ObjectUtils.disposeObject(_imgJob);
         _imgJob = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

