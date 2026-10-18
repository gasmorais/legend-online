package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.templates.OutyardAreaTemplateInfo;
   
   public class OutyardAreaEventTips extends BaseTip
   {
      
      private var titleText:FilterFrameText;
      
      private var descText:FilterFrameText;
      
      private var eventTempInfo:OutyardAreaTemplateInfo;
      
      public function OutyardAreaEventTips()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         titleText = ComponentFactory.Instance.creatComponentByStylename("PlanesEventTips.titleText");
         descText = ComponentFactory.Instance.creatComponentByStylename("PlanesEventTips.descText");
         addChild(titleText);
         addChild(descText);
      }
      
      override protected function updateTransform() : void
      {
         cleanData();
         if(_data)
         {
            eventTempInfo = _data.template as OutyardAreaTemplateInfo;
            titleText.text = eventTempInfo.Name;
            descText.text = eventTempInfo.Description;
            descText.y = titleText.y + titleText.textHeight + 5;
         }
         descText.height = descText.textHeight + 3;
         _bg.width = 200;
         _bg.height = titleText.y + titleText.textHeight + descText.textHeight + 20;
      }
      
      private function cleanData() : void
      {
         titleText.text = "";
         descText.text = "";
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(titleText);
         titleText = null;
         ObjectUtils.disposeObject(descText);
         descText = null;
         eventTempInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

