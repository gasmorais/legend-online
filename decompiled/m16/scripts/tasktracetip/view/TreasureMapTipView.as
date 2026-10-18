package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class TreasureMapTipView extends TaskTraceTipView
   {
      
      private var _icon:BaseItemView;
      
      private var _contentTxt:FilterFrameText;
      
      private var goods:GoodsInfo;
      
      public function TreasureMapTipView()
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
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.TreasureMapTipView.btnTxt");
         _textBtn.width = 180;
         _textBtn.x = 20;
         addChild(_icon);
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _textBtn.enable = false;
         _icon.data = param1.goods;
         _contentTxt.text = LanguageMgr.GetTranslation("tasktracetip.view.TreasureMapTipView.content",param1.goods.templateInfo.TemplateName);
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      private function iconLoadComplete(param1:BaseItemView = null) : void
      {
         _textBtn.enable = true;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:Frame = null;
         super.__btnHandler(param1);
         if(!_data || !_data.goods)
         {
            dispose();
            return;
         }
         FrameControllerManager.instance.armyController.model.currentPage = int(_data.goods.pos / 56) + 1;
         goods = GoodsManager.instance.getGoodsByGoodsIdFromGeneralBag(_data.goods.id);
         if(goods == null)
         {
            _loc2_ = LanguageMgr.GetTranslation("tasktracetip.view.BetterGoodsTipsView.command01");
            MessageTipManager.instance().show(_loc2_);
            TaskTraceTipManager.instance.cleanByType(data.type);
            return;
         }
         _loc3_ = FrameControllerManager.instance.armyController.frame;
         if(!_loc3_)
         {
            FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.EQUIP_PANEL,callBack);
            if(data)
            {
               TaskTraceTipManager.instance.cleanByType(data.type);
            }
         }
         else
         {
            _loc3_["equipBag"]["showEffectByPos"](goods.pos);
         }
      }
      
      private function callBack() : void
      {
         var _loc1_:Frame = FrameControllerManager.instance.armyController.frame;
         if(_loc1_)
         {
            _loc1_ = FrameControllerManager.instance.armyController.frame;
            _loc1_["show"]();
         }
         if(goods)
         {
            _loc1_["equipBag"]["showEffectByPos"](goods.pos);
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
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

