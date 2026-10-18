package magicspring.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringModel;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   
   public class MagicSpringSlotItem extends Component
   {
      
      private var _back:Bitmap;
      
      private var _lockImage:Image;
      
      private var _bufferIcon:BaseIconView;
      
      private var _closeBtn:BaseButton;
      
      private var _bufferNameText:FilterFrameText;
      
      private var _openBtn:TextButton;
      
      private var _timeText:FilterFrameText;
      
      private var _index:int;
      
      private var _data:MagicSpringSlotInfo;
      
      public function MagicSpringSlotItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.MagicSpringSlotItem.back");
         _lockImage = ComponentFactory.Instance.creatComponentByStylename("MagicSpringSlotItem.lockImage");
         _bufferIcon = ComponentFactory.Instance.creatCustomObject("MagicSpringSlotItem.bufferIcon");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("MagicSpringSlotItem.closeBtn");
         _bufferNameText = ComponentFactory.Instance.creatComponentByStylename("MagicSpringSlotItem.bufferNameText");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("MagicSpringSlotItem.openBtn");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("MagicSpringSlotItem.timeText");
         addChild(_back);
         addChild(_lockImage);
         addChild(_bufferIcon);
         addChild(_closeBtn);
         addChild(_bufferNameText);
         addChild(_openBtn);
         addChild(_timeText);
         _openBtn.text = LanguageMgr.GetTranslation("MagicSpringSlotItem.openBtn.text");
      }
      
      private function addEvent() : void
      {
         _openBtn.addEventListener("click",__openClickHandler);
         _closeBtn.addEventListener("click",__closeClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_openBtn)
         {
            _openBtn.removeEventListener("click",__openClickHandler);
         }
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__closeClickHandler);
         }
      }
      
      private function __openClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc5_:int = int(model.slotNeedCost[_index - 2]);
         var _loc6_:String = LanguageMgr.GetTranslation("MagicSpringSlotItem.openSlot.content",_loc5_);
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.data = [payCallBackHandler,_loc5_];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc6_,_loc2_,_loc3_,true,true,true,2);
      }
      
      private function payCallBackHandler(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc4_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         if(_loc4_ >= param3)
         {
            MagicSpringManager.instance.sendMagicSpringRequest(1);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function __closeClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         SoundManager.instance.play("022");
         var _loc5_:String = LanguageMgr.GetTranslation("MagicSpringSlotItem.cancelBuffer.content");
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.data = [cancelBackHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,true,2);
      }
      
      private function cancelBackHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         MagicSpringManager.instance.sendMagicSpringRequest(3,data.tempId);
      }
      
      public function get data() : MagicSpringSlotInfo
      {
         return _data;
      }
      
      public function set data(param1:MagicSpringSlotInfo) : void
      {
         if(_data == param1 && _data != null)
         {
            return;
         }
         _data = param1;
         if(data)
         {
            _lockImage.visible = false;
            _lockImage.tipData = "";
            _closeBtn.visible = true;
            _openBtn.visible = false;
            _bufferIcon.icon = IconFactory.getMagicSpringPath(data.tempInfo.Icon);
            _bufferNameText.text = data.tempInfo.TemplateName;
            _bufferIcon.tipData = data.tempInfo.Desc;
            if(_bufferNameText.numLines == 1)
            {
               _bufferNameText.y = 30;
            }
            else if(_bufferNameText.numLines == 2)
            {
               _bufferNameText.y = 25;
            }
            else
            {
               _bufferNameText.y = 20;
            }
         }
         else
         {
            _closeBtn.visible = false;
            _bufferNameText.text = "";
            _timeText.text = "";
            _bufferIcon.icon = null;
            if(_index <= model.openSlotCount)
            {
               _lockImage.visible = false;
               _openBtn.visible = false;
               _lockImage.tipData = "";
            }
            else
            {
               _lockImage.visible = true;
               _openBtn.visible = _index > model.openSlotCount + 1 ? false : true;
               setOpenTipData();
            }
         }
      }
      
      private function setOpenTipData() : void
      {
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc7_:Array = null;
         var _loc1_:int = 0;
         var _loc5_:String = LanguageMgr.GetTranslation("MagicSpringSlotItem.lockImage.openTipTitle");
         _loc2_ = 1;
         while(_loc2_ <= 3)
         {
            _loc6_ = int(model.potionTempArr[_loc2_ - 1]);
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc6_);
            _loc4_ = int(model["potionCount" + _loc2_]);
            _loc7_ = model.slotOpenCount[_index - 2].split(",");
            _loc1_ = int(_loc7_[_loc2_ - 1]);
            if(_loc4_ >= _loc1_)
            {
               _loc5_ += "\n<font color=\'#04EF25\'>" + LanguageMgr.GetTranslation("MagicSpringSlotItem.lockImage.openTipData",_loc3_.TemplateName,_loc4_,_loc1_) + "</font>";
            }
            else
            {
               _loc5_ += "\n<font color=\'#8C8C8C\'>" + LanguageMgr.GetTranslation("MagicSpringSlotItem.lockImage.openTipData",_loc3_.TemplateName,_loc4_,_loc1_) + "</font>";
            }
            _loc2_++;
         }
         _lockImage.tipData = _loc5_;
      }
      
      public function refreshLeftTime() : void
      {
         if(!data)
         {
            return;
         }
         if(data.validCountDown > 0)
         {
            _timeText.text = DateFormatter.getConsortiaCountDate(data.validCountDown);
         }
         else
         {
            _timeText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
         }
      }
      
      public function get model() : MagicSpringModel
      {
         return MagicSpringManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_lockImage);
         _lockImage = null;
         ObjectUtils.disposeObject(_bufferIcon);
         _bufferIcon = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         ObjectUtils.disposeObject(_bufferNameText);
         _bufferNameText = null;
         ObjectUtils.disposeObject(_timeText);
         _timeText = null;
         ObjectUtils.disposeObject(_openBtn);
         _openBtn = null;
         super.dispose();
      }
   }
}

