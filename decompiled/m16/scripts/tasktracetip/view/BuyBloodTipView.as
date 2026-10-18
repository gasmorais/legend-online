package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import ui.resourcebar.view.quickbuy.QuickBuyFrame;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   
   public class BuyBloodTipView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      public function BuyBloodTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         if(GoodsManager.instance.getGoodsNumBySonType(209) == 0)
         {
            _contentTxt.text = LanguageMgr.GetTranslation("tasktracetip.view.BuyBloodTipView.content01");
            _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.BuyBloodTipView.text01");
            _textBtn.width = 125;
         }
         else
         {
            _contentTxt.text = LanguageMgr.GetTranslation("tasktracetip.view.BuyBloodTipView.content02");
            _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.BuyBloodTipView.text02");
         }
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         var _loc2_:QuickBuyFrame = null;
         var _loc3_:GoodsInfo = null;
         var _loc4_:Frame = null;
         super.__btnHandler(param1);
         if(GoodsManager.instance.getGoodsNumBySonType(209) == 0)
         {
            _loc2_ = ComponentFactory.Instance.createComponentGroupByStylename("resourcesBar.QuickBuyFrame");
            _loc2_.show();
            TaskTraceTipManager.instance.cleanByType(data.type);
         }
         else
         {
            _loc3_ = GoodsManager.instance.getGeneralBagGoodsBySonType(209)[0];
            if(_loc3_)
            {
               _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.BuyBloodTipView.text02");
               _contentTxt.text = LanguageMgr.GetTranslation("tasktracetip.view.BuyBloodTipView.content02");
               FrameControllerManager.instance.armyController.model.currentPage = int(_loc3_.pos / 56) + 1;
               _loc4_ = FrameControllerManager.instance.armyController.frame;
               if(!_loc4_ || _loc4_ && _loc4_.stylename != "army.ArmyFrameII")
               {
                  FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.EQUIP_PANEL,back);
               }
               else
               {
                  _loc4_["defaultContent"] = ArmyPanelEnum.EQUIP_PANEL;
                  _loc4_["equipBag"].showEffectBySontype(209);
                  _loc4_["equipBag"].showFilterBySontype(209);
                  TaskTraceTipManager.instance.cleanByType(data.type);
               }
            }
         }
      }
      
      private function back() : void
      {
         var _loc1_:Frame = FrameControllerManager.instance.armyController.frame;
         if(_loc1_)
         {
            _loc1_["equipBag"].showEffectBySontype(209);
            _loc1_["equipBag"].showFilterBySontype(209);
            TaskTraceTipManager.instance.cleanByType(data.type);
         }
      }
      
      override protected function check() : Boolean
      {
         return false;
      }
   }
}

