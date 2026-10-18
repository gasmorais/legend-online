package antaeus
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.antaeus.AntaeusAssistantData;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerBufferInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.AntaeusManager;
   import yishi.manager.PlayerBufferManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class AntaeusItem extends Component
   {
      
      private var _bit0:Bitmap;
      
      private var _txtInvite:FilterFrameText;
      
      private var _txtCount2:FilterFrameText;
      
      private var _txtCost:FilterFrameText;
      
      private var _bit1:Bitmap;
      
      private var _index:int;
      
      private var _data:AntaeusAssistantData;
      
      private var _money:ScaleFrameImage;
      
      private var assistMaxCount:int;
      
      public function AntaeusItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.antaeus.img1");
         _txtInvite = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txtInvite");
         _txtCount2 = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txtCount2");
         _txtCost = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txtCost");
         _money = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.money");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.antaeus.strInvited");
         addChild(_bit0);
         addChild(_txtInvite);
         addChild(_txtCount2);
         addChild(_txtCost);
         addChild(_money);
         addChild(_bit1);
         _txtCost.text = "";
         _txtInvite.text = LanguageMgr.GetTranslation("antaeus.campaign");
         _bit1.visible = false;
         buttonMode = true;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      public function get campaignName() : String
      {
         return LanguageMgr.GetTranslation("antaeus.campaign.str" + index);
      }
      
      public function set data(param1:AntaeusAssistantData) : void
      {
         _data = param1;
         var _loc2_:PlayerBufferInfo = PlayerBufferManager.instance.getItemBufferInfoByType(8);
         var _loc3_:Number = Number(AntaeusManager.instance.model.antaeusData.userId);
         _bit1.visible = false;
         if(_loc2_)
         {
            if(_loc2_.grade == index && _data && _loc3_ == _data.userId)
            {
               _bit1.visible = true;
            }
         }
         _txtCost.text = costMoney + "";
         _txtCount2.text = campaignName + " " + LanguageMgr.GetTranslation("antaeus.campaign.str0");
         if(index == 4 && _data && _data.assistShuttleCountForMe >= 1)
         {
            this.filters = [UIFilter.getGrayFilter()];
         }
         else
         {
            this.filters = [];
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("click",onClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(index == 4 && _data.assistShuttleCountForMe >= 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("antaeus.shuttle.countMax"));
            return;
         }
         if(_data.assistCountForMe >= 5)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("antaeus.campaign.countMax"));
            return;
         }
         var _loc4_:Number = Number(AntaeusManager.instance.model.antaeusData.userId);
         if(_loc4_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("antaeus.campaign.used"));
            return;
         }
         if(_data.userId == PlayerManager.instance.currentPlayerModel.userInfo.userId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("antaeus.campaign.self"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("antaeus.campaign.invite",costMoney,_data.showData.player.nickName,campaignName);
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc5_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [confirm];
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc2_,_loc3_,_loc5_,false,true,true,1);
      }
      
      private function get costMoney() : int
      {
         var _loc1_:Array = ConfigInfoManager.instance.getAntaeusFunCost();
         if(_data)
         {
            return _loc1_[index - 1] * Math.pow(2,_data.assistCountForMe);
         }
         return 0;
      }
      
      private function confirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            AntaeusManager.instance.sendInvite(index,_data.userId);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_txtInvite);
         _txtInvite = null;
         ObjectUtils.disposeObject(_txtCount2);
         _txtCount2 = null;
         ObjectUtils.disposeObject(_txtCost);
         _txtCost = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_money);
         _money = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

