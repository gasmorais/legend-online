package apex.award
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.templates.ApexRewardDropTemp;
   import yishi.view.community.BaseItemView;
   
   public class ApexAwardItem extends Component
   {
      
      private var icon:BaseItemView;
      
      private var txt:FilterFrameText;
      
      public function ApexAwardItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         icon = ComponentFactory.Instance.creatCustomObject("apex.awardIcon");
         txt = ComponentFactory.Instance.creatComponentByStylename("ui.apex.awardNameTxt");
         addChild(icon);
         addChild(txt);
      }
      
      public function set data(param1:ApexRewardDropTemp) : void
      {
         icon.icon.icon = param1.template.iconPath;
         txt.text = param1.nameAndCount;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(icon);
         icon = null;
         ObjectUtils.disposeObject(txt);
         txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

