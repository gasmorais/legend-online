package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.datas.playerinfo.PlayerBufferInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   
   public class BufferDisapearTipView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      public function BufferDisapearTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _textBtn.text = LanguageMgr.GetTranslation("public.confirm");
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         var _loc4_:PlayerBufferInfo = param1.data as PlayerBufferInfo;
         var _loc5_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_.goodsTemplateId);
         var _loc2_:String = _loc5_ ? GoodsHelp.getGoodColorString(_loc5_.Profile) : GoodsHelp.getGoodColorString(3);
         var _loc3_:String = "[<font color=" + _loc2_ + ">" + _loc4_.name + "</font>]";
         var _loc6_:String = LanguageMgr.GetTranslation("public.BufferDisapear");
         _contentTxt.htmlText = _loc3_ + _loc6_;
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
   }
}

