package vip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import mvc.module.vip.VIPModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class VipGiftItem extends Component
   {
      
      private var _vipTxt:FilterFrameText;
      
      private var _hBox:HBox;
      
      private var _btn:SelectedIconButton;
      
      private var _name:Bitmap;
      
      private var _giftReceiveBtn:TextButton;
      
      public function VipGiftItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _vipTxt = ComponentFactory.Instance.creatComponentByStylename("vip.VipGiftNameTxt");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("vip.Item.Contain");
         _giftReceiveBtn = ComponentFactory.Instance.creatComponentByStylename("vip.giftReceiveBtn");
         addChild(_giftReceiveBtn);
         addChild(_vipTxt);
         addChild(_hBox);
      }
      
      private function initEvent() : void
      {
         _giftReceiveBtn.addEventListener("click",__receiveHandler);
      }
      
      private function removeEvent() : void
      {
         _giftReceiveBtn.removeEventListener("click",__receiveHandler);
      }
      
      public function data(param1:Array, param2:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc8_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         var _loc7_:String = null;
         var _loc5_:String = null;
         param1.sortOn("itemId");
         if(param1 == null || param1.length == 0)
         {
            _vipTxt.text = "";
            _giftReceiveBtn.visible = false;
            ObjectUtils.disposeAllChildren(_hBox);
            return;
         }
         ObjectUtils.disposeAllChildren(_hBox);
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1[_loc6_].itemId);
            _loc8_ = new GoodsInfo();
            _loc8_.templateId = param1[_loc6_].itemId;
            _loc8_.count = param1[_loc6_].count;
            _loc3_ = ComponentFactory.Instance.creatCustomObject("vip.vipGifItem");
            _loc3_.data = _loc8_;
            _hBox.addChild(_loc3_);
            _loc6_++;
         }
         _loc7_ = LanguageMgr.GetTranslation("vip.view.VipGiftItem.vGetNextTime");
         if(param2 == vipModel.vipInfo.VipGrade)
         {
            if(!vipModel.vipInfo.IsTakeGift && Boolean(vipModel.vipInfo.IsVipAndNoExpirt))
            {
               _giftReceiveBtn.visible = false;
               _vipTxt.htmlText = LanguageMgr.GetTranslation("public.colon",_loc7_) + "</br>" + DateFormatter.timeFormat1(vipModel.vipInfo.takeGiftDate);
            }
            else
            {
               _vipTxt.text = "";
               if(vipModel.vipInfo.IsVipAndNoExpirt)
               {
                  _giftReceiveBtn.visible = true;
               }
               else
               {
                  _giftReceiveBtn.visible = false;
               }
            }
         }
         else
         {
            _vipTxt.text = "";
            _giftReceiveBtn.visible = false;
         }
         _loc5_ = LanguageMgr.GetTranslation("vip.view.VipGiftItem.vGet");
         _giftReceiveBtn.text = "VIP" + param2 + _loc5_;
         _name = ComponentFactory.Instance.creatBitmap("asset.vip.GradePrivilegeVip" + param2);
         if(param2 == 9)
         {
            _name.x = -6;
            _name.y = 2;
         }
         else
         {
            _name.x = 4;
            _name.y = 12;
         }
         addChild(_name);
      }
      
      private function __receiveHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!vipModel.vipInfo.IsVipAndNoExpirt)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("vip.view.VipGiftFrame.command01"));
            return;
         }
         if(!vipModel.vipInfo.IsTakeGift)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("vip.view.VipGiftFrame.command02"));
            return;
         }
         VIPManager.Instance.senReceiveGift();
         FrameControllerManager.instance.vipController.hideGiftFrame();
         InfoTipsManager.instance.updateValue(26,0);
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

