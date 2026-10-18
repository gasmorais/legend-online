package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.manager.FrameControllerManager;
   import yishi.view.community.BaseIconView;
   
   public class ShopTimeBuyTipView extends TaskTraceTipView
   {
      
      private var _icon:BaseIconView;
      
      private var _contentTxt:FilterFrameText;
      
      public function ShopTimeBuyTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _icon = ComponentFactory.Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         _icon.icon = ComponentFactory.Instance.creatBitmap("asset.taskTraceTips.ShopIcon");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.RightContentTxt02");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _icon.tipStyle = "yishi.view.tips.OneLineTip";
         addChild(_icon);
         _icon.tipData = LanguageMgr.GetTranslation("tasktracetip.view.ShopTimeBuyTipView.IconTips");
         addChild(_contentTxt);
         _contentTxt.text = "";
         addChild(_textBtn);
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.ShopTimeBuyTipView.btnTxt");
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         if(_data)
         {
            _contentTxt.text = _data.content;
         }
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         SoundManager.instance.play("015",true);
         if(_data && _data.data)
         {
            ShopManager.Instance.shopFrameDefaultPanel = _data.data["isVIPShop"] ? "SHOPFRAME_VIPBUY" : "SHOPFRAME_TIMEBUY";
            if(!_data.data["isVIPShop"] && ShopManager.Instance.model.getTimeBuyList(0).length <= 0)
            {
               TaskTraceTipManager.instance.cleanByType(33);
               return;
            }
            FrameControllerManager.instance.openControllerByInfo("shop");
         }
         TaskTraceTipManager.instance.cleanByType(33);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_icon);
         ObjectUtils.disposeObject(_contentTxt);
         _contentTxt = null;
         _icon = null;
         super.dispose();
      }
   }
}

