package vip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.vip.VipInfo;
   
   public class GradePrivilegeItem extends Sprite implements Disposeable
   {
      
      private var _gradeVipItemLeft:Bitmap;
      
      private var _gradeVipItemRight:Bitmap;
      
      private var _gradeVipItemBg:Bitmap;
      
      private var _gradeVipItemLine:Bitmap;
      
      public function GradePrivilegeItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _gradeVipItemLeft = ComponentFactory.Instance.creatBitmap("asset.vip.GradePrivilegeItem3");
         _gradeVipItemRight = ComponentFactory.Instance.creatBitmap("asset.vip.GradePrivilegeItem1");
         addChild(_gradeVipItemLeft);
         _gradeVipItemLeft.width = 82;
         _gradeVipItemLeft.x = -2;
         _loc1_ = 0;
         while(_loc1_ < 9)
         {
            _gradeVipItemBg = ComponentFactory.Instance.creatBitmap("asset.vip.GradePrivilegeItem2");
            _gradeVipItemLine = ComponentFactory.Instance.creatBitmap("asset.vip.GradePrivilegeItemLine");
            addChild(_gradeVipItemBg);
            _gradeVipItemBg.x = 80 + _loc1_ * 62;
            addChild(_gradeVipItemLine);
            _gradeVipItemLine.x = 140 + _loc1_ * 61;
            _gradeVipItemLine.y = 5;
            _loc1_++;
         }
         addChild(_gradeVipItemRight);
         _gradeVipItemRight.x = 630;
      }
      
      public function initData(param1:Array, param2:int, param3:VipInfo) : void
      {
         var _loc7_:int = 0;
         var _loc5_:Bitmap = null;
         var _loc4_:FilterFrameText = null;
         var _loc6_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("vip.gradeItemLeftTxt");
         addChild(_loc6_);
         _loc6_.x = 5;
         _loc6_.y = 12;
         _loc6_.width = 136;
         _loc6_.text = param1[0].name;
         var _loc8_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.vip.GradePrivilegeItemLight");
         _loc8_.x = 141 + (param3.VipGrade - 1) * 61;
         _loc8_.width = 60;
         if(param3.IsVipAndNoExpirt)
         {
            addChild(_loc8_);
         }
         if(param3.VipGrade == 9)
         {
            _loc8_.width = 62;
         }
         switch(param2)
         {
            case 1:
            case 3:
            case 4:
            case 10:
            case 11:
            case 12:
            case 13:
            case 16:
            case 17:
            case 18:
            case 19:
            case 20:
               _loc7_ = 0;
               while(_loc7_ < param1.length)
               {
                  if(param1[_loc7_].para1 == 0)
                  {
                     _loc5_ = ComponentFactory.Instance.creatBitmap("asset.vip.GradePrivilegeCrossIcon");
                  }
                  else
                  {
                     _loc5_ = ComponentFactory.Instance.creatBitmap("asset.vip.GradePrivilegeConfirmbg");
                  }
                  _loc5_.x = param1[_loc7_].grade * 61 + 98;
                  addChild(_loc5_);
                  _loc7_++;
               }
               break;
            case 2:
            case 6:
            case 7:
            case 8:
            case 9:
            case 14:
            case 15:
               _loc7_ = 0;
               while(_loc7_ < param1.length)
               {
                  if(param1[_loc7_].para1 == 0)
                  {
                     _loc5_ = ComponentFactory.Instance.creatBitmap("asset.vip.GradePrivilegeCrossIcon");
                     _loc5_.x = param1[_loc7_].grade * 61 + 98;
                     addChild(_loc5_);
                  }
                  else
                  {
                     _loc4_ = ComponentFactory.Instance.creatComponentByStylename("vip.gradeItemTxt");
                     _loc4_.x = param1[_loc7_].grade * 61 + 82;
                     addChild(_loc4_);
                     if(param1[_loc7_].type == 6)
                     {
                        _loc4_.text = "+" + param1[_loc7_].para1 + "%";
                     }
                     else if(param1[_loc7_].type == 2)
                     {
                        _loc4_.text = "+" + param1[_loc7_].para1 + LanguageMgr.GetTranslation("vip.view.GradePrivilegeItem.para01");
                     }
                     else if(param1[_loc7_].type == 7)
                     {
                        _loc4_.text = "+" + param1[_loc7_].para1;
                     }
                     else if(param1[_loc7_].type == 8)
                     {
                        _loc4_.text = "+" + param1[_loc7_].para1 + LanguageMgr.GetTranslation("vip.view.GradePrivilegeItem.para02");
                     }
                     else if(param1[_loc7_].type == 9)
                     {
                        _loc4_.text = "+" + param1[_loc7_].para1 + LanguageMgr.GetTranslation("vip.view.GradePrivilegeItem.para02");
                     }
                     else if(param1[_loc7_].type == 14)
                     {
                        _loc4_.text = "+" + param1[_loc7_].para1 + LanguageMgr.GetTranslation("vip.view.GradePrivilegeItem.para02");
                     }
                     if(param1[_loc7_].type == 15)
                     {
                        _loc4_.text = "-" + param1[_loc7_].para1 + "%";
                     }
                  }
                  _loc7_++;
               }
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

