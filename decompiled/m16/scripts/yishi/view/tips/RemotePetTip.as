package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.pet.PetData;
   
   public class RemotePetTip extends BaseTip
   {
      
      private var _blackKingBg:Scale9CornerImage;
      
      private var _redBg:Scale9CornerImage;
      
      private var _yellowBg:Scale9CornerImage;
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _blueBg:Scale9CornerImage;
      
      private var _greenBg:Scale9CornerImage;
      
      private var _whiteBg:Scale9CornerImage;
      
      private var content:RemotePetTipContent;
      
      public function RemotePetTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _blackKingBg = ComponentFactory.Instance.creatComponentByStylename("core.blackItemTipsBg");
         _redBg = ComponentFactory.Instance.creatComponentByStylename("core.redItemTipsBg");
         _yellowBg = ComponentFactory.Instance.creatComponentByStylename("core.yellowItemTipsBg");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _blueBg = ComponentFactory.Instance.creatComponentByStylename("core.blueItemTipsBg");
         _greenBg = ComponentFactory.Instance.creatComponentByStylename("core.greenItemTipsBg");
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         addChild(_blackKingBg);
         addChild(_redBg);
         addChild(_yellowBg);
         addChild(_purpleBg);
         addChild(_blueBg);
         addChild(_greenBg);
         addChild(_whiteBg);
         content = new RemotePetTipContent();
         _bg.width = 300;
         _bg.height = 320;
      }
      
      override protected function updateTransform() : void
      {
         addChild(content);
         if(tipData is PetData)
         {
            content.data = tipData as PetData;
         }
         _bg.height = content.height + 20;
         _blackKingBg.width = _redBg.width = _yellowBg.width = _purpleBg.width = _blueBg.width = _greenBg.width = _whiteBg.width = _bg.width;
         _blackKingBg.height = _redBg.height = _yellowBg.height = _purpleBg.height = _blueBg.height = _greenBg.height = _whiteBg.height = _bg.height - 10;
         if(tipData)
         {
            showProfileBg((tipData as PetData).quality);
         }
      }
      
      private function showProfileBg(param1:int) : void
      {
         _blackKingBg.visible = _redBg.visible = _yellowBg.visible = _purpleBg.visible = _blueBg.visible = _greenBg.visible = _whiteBg.visible = _bg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               _whiteBg.visible = true;
               break;
            case 1:
               _greenBg.visible = true;
               break;
            case 2:
               _blueBg.visible = true;
               break;
            case 3:
               _purpleBg.visible = true;
               break;
            case 4:
               _yellowBg.visible = true;
               break;
            case 5:
               _redBg.visible = true;
               break;
            case 6:
               _blackKingBg.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(content);
         content = null;
         ObjectUtils.disposeObject(_blackKingBg);
         _blackKingBg = null;
         ObjectUtils.disposeObject(_redBg);
         _redBg = null;
         ObjectUtils.disposeObject(_yellowBg);
         _yellowBg = null;
         ObjectUtils.disposeObject(_purpleBg);
         _purpleBg = null;
         ObjectUtils.disposeObject(_blueBg);
         _blueBg = null;
         ObjectUtils.disposeObject(_greenBg);
         _greenBg = null;
         ObjectUtils.disposeObject(_whiteBg);
         _whiteBg = null;
         ObjectUtils.removeChildAllChildren(this);
         super.dispose();
      }
   }
}

