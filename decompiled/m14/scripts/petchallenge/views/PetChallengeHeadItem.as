package petchallenge.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.PetChallengeManager;
   import mvc.module.pet.PetData;
   import mvc.module.petchallenge.PetChallengeModel;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PetChallengeHeadItem extends Component
   {
      
      private var back:Bitmap;
      
      private var headIcon:BaseIconView;
      
      private var fightText:FilterFrameText;
      
      private var _data:PetData;
      
      public function PetChallengeHeadItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatBitmap("asset.PetChallengeHeadItem.back");
         headIcon = ComponentFactory.Instance.creatCustomObject("PetChallengeSortItem.petIcon");
         fightText = ComponentFactory.Instance.creatComponentByStylename(".PetChallengeHeadItem.fightText");
         addChild(back);
         addChild(headIcon);
         addChild(fightText);
      }
      
      public function set data(param1:PetData) : void
      {
         _data = param1;
         if(!_data)
         {
            back.visible = true;
            headIcon.icon = null;
            fightText.text = "";
         }
         else
         {
            back.visible = false;
            headIcon.icon = IconFactory.getPetHeadItemIcon(_data.templateId);
            if(model.curSelectIndex == 0)
            {
               headIcon.tipData = "<font color=\'#5ccae9\'>" + _data.name + "\n" + "</font>" + "<font color=\'#ffe400\'>" + LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.fightingTxt",_data.fightPower) + "</font>";
               fightText.text = "";
            }
            else
            {
               headIcon.tipData = null;
               fightText.text = _data.fightPower + "";
            }
         }
      }
      
      private function get model() : PetChallengeModel
      {
         return PetChallengeManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(headIcon);
         headIcon = null;
         ObjectUtils.disposeObject(fightText);
         fightText = null;
         super.dispose();
      }
   }
}

