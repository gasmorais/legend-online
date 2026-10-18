package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import tasktracetip.data.TipMessageData;
   import yishi.SwitchPageHelp;
   import yishi.datas.goods.GoodsInfo;
   import yishi.scene.SceneManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class SinglepassHasBugleYipsView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      private var _info:GoodsInfo;
      
      private var _icon:BaseItemView;
      
      public function SinglepassHasBugleYipsView()
      {
         super();
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         if(data != null)
         {
            _contentTxt.text = data.content;
            _icon.data = data.goods;
         }
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.SinglepassHasBugleYipsView.ContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _textBtn.text = LanguageMgr.GetTranslation("taskTrace.SinglepassHasBugleYipsView.intoSinglePass");
         _textBtn.backgound.width = 180;
         _textBtn.textField.x = 9;
         _textBtn.x = 17;
         _icon = ComponentFactory.Instance.creatCustomObject("taskTraceTips.ItemView");
         _icon.iconBack = iconLoadComplete;
         addChild(_icon);
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      private function iconLoadComplete(param1:BaseItemView = null) : void
      {
         _textBtn.enable = true;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         if(SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE" || SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            SwitchPageHelp.goSpaceAndFind(20);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("taskTrace.SinglepassHasBugleYipsView.TipInfo"));
         }
         dispose();
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

