package consortia.view.myConsortia.treasure
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.net.ConsortiaSocektSendManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.TreasureInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConsortiaTreasureTemplateInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class TreasureListItem extends Component
   {
      
      private var _data:TreasureInfo;
      
      private var bg:Bitmap;
      
      private var _IconBg:Bitmap;
      
      private var _itemView:BaseItemView;
      
      private var _hbox:HBox;
      
      private var _Btn:TextButton;
      
      private var _FreeBtn:IconButton;
      
      private var _title:FilterFrameText;
      
      private var _time:FilterFrameText;
      
      private var tmpinfo:ConsortiaTreasureTemplateInfo;
      
      public function TreasureListItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         bg = ComponentFactory.Instance.creatBitmap("asset.consortia.TreasureItemBg");
         _IconBg = ComponentFactory.Instance.creatBitmap("asset.consortia.TreasureItemIconBg");
         _itemView = ComponentFactory.Instance.creatCustomObject("consortia.TreasureItem.ItemView");
         _Btn = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureItem.Btn");
         _FreeBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureItem.FreeBtn");
         _title = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureItem.title");
         _time = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureItem.time");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureItem.Hbox");
         addChild(bg);
         addChild(_IconBg);
         addChild(_itemView);
         addChild(_FreeBtn);
         _FreeBtn.visible = false;
         addChild(_Btn);
         addChild(_title);
         addChild(_time);
         addChild(_hbox);
      }
      
      public function set data(param1:TreasureInfo) : void
      {
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         if(!param1)
         {
            return;
         }
         _data = param1;
         tmpinfo = ConsortiaManager.instance.getTreasureTempByID(_data.treasureTemplateId);
         _title.text = tmpinfo.TemplateName;
         _title.setFrame(tmpinfo.Quality);
         _time.text = LanguageMgr.GetTranslation("consortia.TreasureItem.time") + refreshTime(tmpinfo.RewardSeconds);
         _Btn.text = "" + model.open_costArr[0];
         var _loc2_:String = IconFactory.getCommonIconPath("/treasure/" + tmpinfo.Type + "_" + tmpinfo.Quality + ".png");
         _itemView.icon.icon = _loc2_;
         var _loc4_:Array = tmpinfo.Drop.split("|");
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_].split(",");
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = int(_loc6_[0]);
            _loc7_.count = int(_loc6_[1]);
            _loc3_ = ComponentFactory.Instance.creatCustomObject("consortia.TreasureItem.HBoxItem");
            _loc3_.data = _loc7_;
            _hbox.addChild(_loc3_);
            _loc5_++;
         }
      }
      
      public function set free(param1:Boolean) : void
      {
         if(param1)
         {
            _FreeBtn.visible = true;
            _Btn.visible = false;
         }
         else
         {
            _FreeBtn.visible = false;
            _Btn.visible = true;
         }
      }
      
      private function _FreeBtnHandle(param1:MouseEvent) : void
      {
         if(model.treasureGroupInfo.leftCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.TreasureFreeMining.leftCount"));
         }
         else
         {
            ConsortiaSocektSendManager.sendOpenTreasure(4,-1,_data.treasureId);
            NotificationManager.instance.sendNotification("OPEN_TREASURE_NORMAL");
         }
      }
      
      private function _BtnHandle(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(model.treasureGroupInfo.leftCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.TreasureFreeMining.leftCount"));
         }
         else
         {
            SoundManager.instance.play("022");
            _loc4_ = int(model.open_costArr[0]);
            SimpleAlertHelper.instance.data = [_BtnResultHandle,_loc4_];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("consortia.TreasureList.Mining.alertText",_loc4_);
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,true,true,2);
         }
      }
      
      private function _BtnResultHandle(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point >= param3)
            {
               ConsortiaSocektSendManager.sendOpenTreasure(4,1,_data.treasureId);
            }
            else
            {
               RechargeAlertMannager.show();
            }
         }
      }
      
      private function initEvent() : void
      {
         _FreeBtn.addEventListener("click",_FreeBtnHandle);
         _Btn.addEventListener("click",_BtnHandle);
      }
      
      private function removeEvent() : void
      {
         if(_FreeBtn)
         {
            _FreeBtn.removeEventListener("click",_FreeBtnHandle);
         }
         if(_Btn)
         {
            _Btn.removeEventListener("click",_BtnHandle);
         }
      }
      
      private function refreshTime(param1:int) : String
      {
         var _loc5_:* = null;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         if(param1 >= 3600)
         {
            _loc3_ = param1 / 3600;
         }
         if(param1 >= 60)
         {
            _loc7_ = param1 % 3600 / 60;
         }
         _loc6_ = param1 % 3600 % 60;
         var _loc4_:String = _loc3_ >= 10 ? _loc3_.toString() : "0" + _loc3_;
         var _loc8_:String = _loc7_ >= 10 ? _loc7_.toString() : "0" + _loc7_;
         var _loc2_:String = _loc6_ >= 10 ? _loc6_.toString() : "0" + _loc6_;
         return _loc4_ + ": " + _loc8_ + ": " + _loc2_;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(bg)
         {
            ObjectUtils.disposeObject(bg);
         }
         bg = null;
         if(_IconBg)
         {
            ObjectUtils.disposeObject(_IconBg);
         }
         _IconBg = null;
         if(_itemView)
         {
            ObjectUtils.disposeObject(_itemView);
         }
         _itemView = null;
         if(_Btn)
         {
            ObjectUtils.disposeObject(_Btn);
         }
         _Btn = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
         }
         _time = null;
         if(_hbox)
         {
            ObjectUtils.disposeObject(_hbox);
         }
         _hbox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

