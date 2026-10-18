package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PetHallowsManager;
   
   public class PetHallowsLookTips extends BaseTip
   {
      
      private var titleImage:Bitmap;
      
      private var nameText:FilterFrameText;
      
      private var stateText:FilterFrameText;
      
      private var fightText:FilterFrameText;
      
      private var vBox:VBox;
      
      public function PetHallowsLookTips()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         titleImage = ComponentFactory.Instance.creatBitmap("asset.PetHallowsLookTips.titleBg");
         nameText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsLookTips.nameText");
         stateText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsLookTips.stateText");
         fightText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsLookTips.fightText");
         vBox = ComponentFactory.Instance.creatComponentByStylename("PetHallowsLookTips.vBox");
         addChild(titleImage);
         addChild(nameText);
         addChild(stateText);
         addChild(fightText);
         addChild(vBox);
         nameText.text = LanguageMgr.GetTranslation("PetHallowsLookTips.nameText.text");
         stateText.text = LanguageMgr.GetTranslation("PetHallowsLookTips.stateText.text");
         fightText.text = LanguageMgr.GetTranslation("public.playerInfo.ap");
         _bg.width = 225;
         _bg.height = 120;
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:ThaneInfo = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:PetHallowsLookItem = null;
         vBox.removeAllChild();
         if(tipData)
         {
            _loc1_ = tipData as ThaneInfo;
            _loc3_ = petHallowsTempLengs;
            _loc4_ = 1;
            while(_loc4_ <= _loc3_)
            {
               _loc2_ = new PetHallowsLookItem(_loc4_);
               _loc2_.data = _loc1_.getLookPetHallowByType(_loc4_);
               vBox.addChild(_loc2_);
               _loc4_++;
            }
            _bg.height = vBox.height + 40;
         }
      }
      
      private function get petHallowsTempLengs() : int
      {
         return PetHallowsManager.instance.model.hallowsTempList.length;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(titleImage);
         titleImage = null;
         ObjectUtils.disposeObject(nameText);
         nameText = null;
         ObjectUtils.disposeObject(stateText);
         stateText = null;
         ObjectUtils.disposeObject(fightText);
         fightText = null;
         ObjectUtils.disposeObject(vBox);
         vBox = null;
         super.dispose();
      }
   }
}

