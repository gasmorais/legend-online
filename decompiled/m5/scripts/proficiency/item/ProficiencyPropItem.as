package proficiency.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.templates.ProficiencyTempInfo;
   
   public class ProficiencyPropItem extends Component
   {
      
      private var _back:Bitmap;
      
      private var _titleImage:ScaleFrameImage;
      
      private var _propText1:FilterFrameText;
      
      private var _propText2:FilterFrameText;
      
      private var _propText3:FilterFrameText;
      
      private var _propText4:FilterFrameText;
      
      private var type:int;
      
      public function ProficiencyPropItem(param1:int)
      {
         super();
         type = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _back = ComponentFactory.Instance.creatBitmap("asset.ProficiencyPropItem.back");
         _titleImage = ComponentFactory.Instance.creatComponentByStylename("ProficiencyPropItem.titleImage");
         addChild(_back);
         addChild(_titleImage);
         _titleImage.setFrame(type);
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            this["_propText" + _loc1_] = ComponentFactory.Instance.creatComponentByStylename("ProficiencyPropItem.propText");
            this["_propText" + _loc1_].y = (_loc1_ - 1) * 25 + 45;
            addChild(this["_propText" + _loc1_]);
            _loc1_++;
         }
      }
      
      public function setPropView(param1:ProficiencyTempInfo) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         var _loc4_:Array = [param1.Attack,param1.PhyDefence,param1.MagDefence,param1.Live];
         _loc2_ = 1;
         while(_loc2_ <= 4)
         {
            _loc3_ = LanguageMgr.GetTranslation("ProficiencyPropItem.propText.text" + _loc2_);
            if(type == 1)
            {
               this["_propText" + _loc2_].htmlText = _loc3_ + " " + _loc4_[_loc2_ - 1];
            }
            else
            {
               this["_propText" + _loc2_].htmlText = _loc3_ + "<font color=\'#00ff00\'> " + _loc4_[_loc2_ - 1] + "</font>";
            }
            _loc2_++;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_titleImage);
         _titleImage = null;
         ObjectUtils.disposeObject(_propText1);
         _propText1 = null;
         ObjectUtils.disposeObject(_propText2);
         _propText2 = null;
         ObjectUtils.disposeObject(_propText3);
         _propText3 = null;
         ObjectUtils.disposeObject(_propText4);
         _propText4 = null;
         super.dispose();
      }
   }
}

