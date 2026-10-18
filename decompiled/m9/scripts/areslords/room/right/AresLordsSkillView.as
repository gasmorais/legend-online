package areslords.room.right
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.areslords.AresLordsSkillInfo;
   import mvc.module.armyII.SkillInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class AresLordsSkillView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _icon:BaseIconView;
      
      private var _numBg:Image;
      
      private var _numTxt:FilterFrameText;
      
      public function AresLordsSkillView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightSkillBg");
         _icon = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightSkillIcon");
         _numBg = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightSkillNumBg");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.RightSkillNumTxt");
         addChild(_bg);
         addChild(_icon);
         addChild(_numBg);
         addChild(_numTxt);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_numBg);
         _numBg = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         super.dispose();
      }
      
      public function set data(param1:AresLordsSkillInfo) : void
      {
         var _loc2_:SkillInfo = new SkillInfo();
         _loc2_.templateId = param1.skillTempId;
         _icon.icon = IconFactory.getTecIconByIcon(_loc2_.templateInfo.Icons);
         _icon.tipData = _loc2_;
         _numTxt.text = param1.skillCount + "";
      }
   }
}

