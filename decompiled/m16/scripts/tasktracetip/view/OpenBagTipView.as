package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import events.FashionEvent;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import mvc.module.fashion.FashionModel;
   import tasktracetip.data.TipMessageData;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.view.community.BaseItemView;
   
   public class OpenBagTipView extends TaskTraceTipView
   {
      
      private var _icon:BaseItemView;
      
      private var _contentTxt:FilterFrameText;
      
      public function OpenBagTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _icon = ComponentFactory.Instance.creatCustomObject("taskTraceTips.ItemView");
         _icon.iconBack = iconLoadComplete;
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.OpenBagTipView.text");
         addChild(_icon);
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _textBtn.enable = false;
         _icon.data = param1.goods;
         _contentTxt.text = param1.content;
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      private function iconLoadComplete(param1:BaseItemView = null) : void
      {
         _textBtn.enable = true;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         var _loc3_:Frame = null;
         var _loc2_:GoodsInfo = null;
         super.__btnHandler(param1);
         FrameControllerManager.instance.armyController.model.currentPage = int(_data.goods.pos / 56) + 1;
         if(FrameControllerManager.instance.armyController.model.currentOpenPanel == ArmyPanelEnum.EQUIP_PANEL)
         {
            _loc3_ = FrameControllerManager.instance.armyController.frame;
            if(fashionModel.isFashion(_data.goods))
            {
               fashionModel.selectedPanel = "FASHION_PANEL";
               fashionModel.dispatchEvent(new FashionEvent("SWITCH_EQUIPVIEW",null));
            }
         }
         if(!_loc3_)
         {
            FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.EQUIP_PANEL,back);
         }
         else
         {
            _loc3_["defaultContent"] = ArmyPanelEnum.EQUIP_PANEL;
            _loc2_ = GoodsManager.instance.getGoodsByGoodsIdFromGeneralBag(_data.goods.id);
            if(_loc2_)
            {
               _loc3_["equipBag"].showEffectByPos(_data.goods.pos);
               _loc3_["equipBag"].showFilterByPos(_data.goods.pos);
            }
            TaskTraceTipManager.instance.cleanByType(data.type);
         }
      }
      
      override public function dispose() : void
      {
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
         if(_contentTxt)
         {
            _contentTxt.dispose();
         }
         _contentTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
      
      private function back() : void
      {
         var _loc1_:GoodsInfo = null;
         var _loc2_:Frame = FrameControllerManager.instance.armyController.frame;
         if(_loc2_)
         {
            _loc1_ = GoodsManager.instance.getGoodsByGoodsIdFromGeneralBag(_data.goods.id);
            if(_loc1_)
            {
               _loc2_["equipBag"].showEffectByPos(_data.goods.pos);
               _loc2_["equipBag"].showFilterByPos(_data.goods.pos);
            }
            if(fashionModel.isFashion(_data.goods))
            {
               fashionModel.selectedPanel = "FASHION_PANEL";
               fashionModel.dispatchEvent(new FashionEvent("SWITCH_EQUIPVIEW",null));
            }
            TaskTraceTipManager.instance.cleanByType(data.type);
         }
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
   }
}

