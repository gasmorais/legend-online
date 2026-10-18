package pet.learnskill
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PetSkillBookItemView extends Component
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _numTxt:FilterFrameText;
      
      private var _icon:BaseIconView;
      
      private var _graspBtn:TextButton;
      
      private var _numBg:ScaleBitmapImage;
      
      private var _container:Component;
      
      private var _buyBtn:TextButton;
      
      private var _image:ScaleFrameImage;
      
      private var _data:GoodsTemplateInfo;
      
      private var _gray:Array;
      
      public var count:int = 0;
      
      private var _enable:Boolean = true;
      
      private var _isLearned:Boolean;
      
      public function PetSkillBookItemView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("core.ItemBack");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("core.BoxGoodsItemProfileBG");
         _profileImg.mouseChildren = _profileImg.mouseEnabled = false;
         _profileImg.width = _profileImg.height = 50;
         _back.width = _back.height = 50;
         _icon = ComponentFactory.Instance.creatCustomObject("petSkill.SkillBookIcon");
         _graspBtn = ComponentFactory.Instance.creatComponentByStylename("petskill.graspBtn");
         _numBg = ComponentFactory.Instance.creatComponentByStylename("petskill.SkillNumBack");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("petskill.BookNumTxt");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("petskill.BuyBtn1");
         _image = ComponentFactory.Instance.creatComponentByStylename("petskill.SkillIconBack");
         _container = new Component();
         _container.mouseChildren = _container.mouseEnabled = false;
         _container.addChild(_back);
         _container.addChild(_icon);
         _gray = [UIFilter.getGrayFilter()];
         _graspBtn.visible = false;
         _graspBtn.text = LanguageMgr.GetTranslation("PetSkillBookItemView.learn");
         _graspBtn.mouseChildren = _graspBtn.mouseEnabled = false;
         _graspBtn.filters = _gray;
         _numBg.mouseChildren = _numBg.mouseEnabled = false;
         _numTxt.text = "";
         _buyBtn.text = LanguageMgr.GetTranslation("pet.PetSkillItemViewII.learnTxt");
         addChild(_container);
         addChild(_profileImg);
         addChild(_buyBtn);
         addChild(_numBg);
         addChild(_numTxt);
         addChild(_graspBtn);
         addChild(_image);
         _buyBtn.visible = false;
         _numBg.visible = false;
         _numTxt.visible = false;
         this.tipStyle = "yishi.view.tips.goods.SkillTips";
         this.isFollowMouse = false;
         this.tipDirctions = "4,6,5,7,0,1,2,3";
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_profileImg);
         _profileImg = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_graspBtn);
         _graspBtn = null;
         ObjectUtils.disposeObject(_image);
         _image = null;
         ObjectUtils.disposeObject(_numBg);
         _numBg = null;
         ObjectUtils.disposeObject(_container);
         _container = null;
      }
      
      public function get data() : GoodsTemplateInfo
      {
         return _data;
      }
      
      public function set data(param1:GoodsTemplateInfo) : void
      {
         var _loc2_:SkillTempInfo = null;
         var _loc3_:String = null;
         if(isDie)
         {
            return;
         }
         _data = param1;
         _profileImg.visible = false;
         if(_data)
         {
            _icon.visible = true;
            mouseChildren = true;
            mouseEnabled = true;
            _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(_data.Property1);
            _loc3_ = IconFactory.getCommonIconPath(_loc2_.Icons);
            if(_icon.icon != _loc3_)
            {
               _icon.icon = _loc3_;
            }
            this.tipData = _loc2_;
            if(_data.Profile > 1)
            {
               _profileImg.visible = true;
               _profileImg.setFrame(_data.Profile - 1);
            }
            update();
         }
         else
         {
            this.mouseChildren = this.mouseEnabled = false;
            _icon.icon = null;
            _numTxt.text = "";
            _numBg.visible = false;
            _numTxt.visible = false;
            _icon.visible = false;
            _graspBtn.visible = false;
            _image.visible = false;
            _buyBtn.visible = false;
            this.tipData = null;
         }
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         if(_enable == param1)
         {
            return;
         }
         _enable = param1;
         if(_enable)
         {
            this.filters = [];
         }
         else
         {
            this.filters = _gray;
         }
      }
      
      public function set isLearned(param1:Boolean) : void
      {
         _isLearned = param1;
         update();
      }
      
      private function update() : void
      {
         if(!_data)
         {
            return;
         }
         if(isDie)
         {
            return;
         }
         var _loc1_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_data.Property1);
         if(!_loc1_)
         {
            return;
         }
         _image.visible = false;
         if(_isLearned)
         {
            _graspBtn.visible = true;
            _buyBtn.visible = false;
            this.filters = _gray;
            if(_loc1_.UseWay == 2)
            {
               _image.visible = true;
               _image.setFrame(3);
            }
         }
         else
         {
            if(_loc1_.UseWay == 2)
            {
               _image.visible = true;
               _image.setFrame(3);
            }
            _graspBtn.visible = false;
            _buyBtn.visible = true;
            this.filters = [];
         }
         count = GoodsManager.instance.getGoodsNumByTempId(_data.TemplateId);
         if(count > 0)
         {
            _numBg.visible = true;
            _numTxt.visible = true;
            _numTxt.text = count + "";
            _numBg.width = _numTxt.textWidth + 7;
            _numBg.x = 45 - _numBg.width - 1;
         }
         else
         {
            _numBg.visible = false;
            _numTxt.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         uintView();
         super.dispose();
         _data = null;
      }
   }
}

