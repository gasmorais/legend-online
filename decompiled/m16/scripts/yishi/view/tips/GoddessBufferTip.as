package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import yishi.datas.templates.BufferTemplateInfo;
   
   public class GoddessBufferTip extends BaseTip
   {
      
      private var _buffDesText:FilterFrameText;
      
      private var _title:FilterFrameText;
      
      public function GoddessBufferTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _buffDesText = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.buffdesTxt");
         _title = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.buffTitleTxt");
         _bg.width = 180;
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:String = null;
         var _loc2_:BufferTemplateInfo = null;
         if(tipData)
         {
            _loc1_ = tipData.title;
            _loc2_ = tipData.buffTemp;
            _title.text = _loc1_;
            _buffDesText.htmlText = _loc2_.BufferName;
            _buffDesText.height = _buffDesText.numLines * 17;
            _bg.height = _buffDesText.y + _buffDesText.height + 10;
            addChild(_buffDesText);
            addChild(_title);
         }
      }
   }
}

