package monster.item
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.monster.MonsterModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.MonsterManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class MonsterSkillIItem extends Component implements IManualSize
   {
      
      private var _back:ScaleFrameImage;
      
      private var _skillIcon:BaseIconView;
      
      private var _lockImage:Bitmap;
      
      private var _lockText:FilterFrameText;
      
      private var _gradeImage:ScaleBitmapImage;
      
      private var _gradeText:FilterFrameText;
      
      private var showType:int;
      
      private var index:int;
      
      private var _data:SkillTempInfo;
      
      public function MonsterSkillIItem(param1:int, param2:int)
      {
         super();
         showType = param1;
         index = param2;
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,65,65);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillIItem.back");
         _skillIcon = ComponentFactory.Instance.creatCustomObject("MonsterSkillIItem.skillIcon");
         _lockImage = ComponentFactory.Instance.creatBitmap("asset.MonsterSkillIItem.lockImage");
         _lockText = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillIItem.lockText");
         _gradeImage = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillIItem.gradeImage");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillIItem.gradeText");
         addChild(_back);
         _back.setFrame(showType);
         addChild(_skillIcon);
         addChild(_lockImage);
         addChild(_lockText);
         addChild(_gradeImage);
         addChild(_gradeText);
         if(showType == 1)
         {
            _skillIcon.scaleX = _skillIcon.scaleY = 0.8;
            _skillIcon.x = _skillIcon.y = 1;
         }
         else
         {
            _skillIcon.scaleX = _skillIcon.scaleY = 0.85;
            _skillIcon.x = _skillIcon.y = -1;
         }
      }
      
      public function get data() : SkillTempInfo
      {
         return _data;
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         var _loc2_:SkillTempInfo = null;
         _data = param1;
         clean();
         if(data)
         {
            _skillIcon.icon = IconFactory.getTecIconByIcon(data.Icons);
            _skillIcon.tipData = param1;
            if(showType == 2)
            {
               _gradeImage.visible = true;
               _loc2_ = model.getMonsterMaxSkillTemp(data.SonType);
               _gradeText.text = data.Grades + "/" + _loc2_.Grades;
            }
         }
         else
         {
            _skillIcon.icon = null;
            if(showType == 1)
            {
               _lockImage.visible = true;
               _lockText.text = LanguageMgr.GetTranslation("MonsterFrame.propView.lockText",index + 1);
            }
         }
      }
      
      private function clean() : void
      {
         _lockImage.visible = false;
         _lockText.text = "";
         _gradeImage.visible = false;
         _gradeText.text = "";
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = null;
         ObjectUtils.disposeObject(_lockImage);
         _lockImage = null;
         ObjectUtils.disposeObject(_lockText);
         _lockText = null;
         ObjectUtils.disposeObject(_gradeImage);
         _gradeImage = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         super.dispose();
      }
   }
}

