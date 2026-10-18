package battle.view.ui.attackmode
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import yishi.view.tips.BaseTip;
   
   public class AttackModeBtnTip extends BaseTip
   {
      
      private var _title:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      public function AttackModeBtnTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 180;
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.SkillNameText");
         _describe = ComponentFactory.Instance.creatComponentByStylename("tips.AttackModeBtnDescribeText");
      }
      
      override protected function updateTransform() : void
      {
         _title.text = tipData[0];
         _title.x = 5;
         _title.y = 2;
         addChild(_title);
         _describe.width = 190;
         _describe.text = tipData[1];
         _describe.y = 25;
         _describe.x = 5;
         addChild(_describe);
         _bg.height = _describe.y + _describe.textHeight + 10;
      }
   }
}

