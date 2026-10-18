package child.handin
{
   import child.attribute.ChildShowAvatar;
   import child.equip.ChildBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.children.ChildData;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.Progress;
   
   public class ChildLookUpFrame extends Frame
   {
      
      public var isSelf:Boolean;
      
      private var _bg:ScaleFrameImage;
      
      private var _childAvatar:ChildShowAvatar;
      
      private var _childEquipList:Sprite;
      
      private var _isEnterWar:Boolean;
      
      private var _fightImg:Bitmap;
      
      private var _fightBmd:BitmapData;
      
      private var _fightSp:Sprite;
      
      private var _equip0:ChildBagCell;
      
      private var _equip1:ChildBagCell;
      
      private var _equip2:ChildBagCell;
      
      private var _equip3:ChildBagCell;
      
      private var _equip4:ChildBagCell;
      
      private var _equip5:ChildBagCell;
      
      private var _equip6:ChildBagCell;
      
      private var _equip7:ChildBagCell;
      
      private var _name:FilterFrameText;
      
      private var _data:ChildData;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _progressBg:Bitmap;
      
      private var _progressTxt:FilterFrameText;
      
      private var _progress:Progress;
      
      protected var _gradeImg:Image;
      
      protected var _levelText:FilterFrameText;
      
      public function ChildLookUpFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildShowView.bg");
         _childAvatar = new ChildShowAvatar();
         _childEquipList = new Sprite();
         _name = ComponentFactory.Instance.creatComponentByStylename("ChildShowView.nameTxt");
         _name.x = 0;
         _name.y = 0;
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("ChildLookUpFrame.GradeTxt");
         _fightImg = ComponentFactory.Instance.creatBitmap("asset.child.ChildAttributeBottomView.fightImage");
         _fightBmd = ComponentFactory.Instance.creatBitmapData("asset.child.ChildAttributeBottomView.fightRes");
         _progressBg = ComponentFactory.Instance.creatBitmap("asset.child.ChildFosterView.proBack");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("ChildFosterViewII.proTitle");
         _gradeImg = ComponentFactory.Instance.creatComponentByStylename("ChildLookUpFrame.ChildrenGradeImg");
         _levelText = ComponentFactory.Instance.creatComponentByStylename("ChildLookUpFrame.levelText");
         _fightSp = new Sprite();
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            this["_equip" + _loc1_] = ComponentFactory.Instance.creatCustomObject("ChildLookUpFrame.bagCell",[false,false]);
            _childEquipList.addChild(this["_equip" + _loc1_]);
            if(_loc1_ >= 4)
            {
               this["_equip" + _loc1_].x = 324;
            }
            else
            {
               this["_equip" + _loc1_].x = 0;
            }
            this["_equip" + _loc1_].y = _loc1_ % 4 * 65;
            _loc1_++;
         }
         addToContent(_bg);
         addToContent(_name);
         addToContent(_gradeTxt);
         addToContent(_childAvatar);
         _childAvatar.x = 50;
         _childAvatar.y = 62;
         addToContent(_childEquipList);
         _childEquipList.addChild(_fightImg);
         _fightImg.x = 101;
         _fightImg.y = 265;
         _childEquipList.addChild(_fightSp);
         _fightSp.x = 183;
         _fightSp.y = 262;
         _childEquipList.y = 50;
         _progress = ComponentFactory.Instance.creatComponentByStylename("ChildFosterView.progress");
         _progress.x = 64;
         _progress.y = 327;
         addToContent(_progressBg);
         _progressBg.x = -1;
         _progressBg.y = 325;
         addToContent(_progress);
         addToContent(_progressTxt);
         _progressTxt.text = LanguageMgr.GetTranslation("child.attribute.ChildItemView.describeTxt02");
         addToContent(_gradeImg);
         addToContent(_levelText);
      }
      
      private function initEvent() : void
      {
      }
      
      public function set data(param1:ChildData) : void
      {
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:ConfigInfosTempInfo = null;
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:GoodsInfo = null;
         _data = param1;
         _name.text = LanguageMgr.GetTranslation("child.ChildLookUpFrame.childName") + _data.name;
         _name.y = 0;
         var _loc7_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
         _gradeTxt.text = _loc7_.JobName;
         _levelText.text = _data.growthGrade + "";
         _childAvatar.data = _data;
         if(_data.state == 0)
         {
            _bg.setFrame(_data.sex + 1);
            _childEquipList.visible = false;
            _progress.visible = true;
            _progressBg.visible = true;
            _progressTxt.visible = true;
            _loc8_ = 1;
            _loc3_ = 25200;
            _loc6_ = TempleteManager.instance.getConfigInfoByConfigName("adult_child_time");
            if(_loc6_ && parseInt(_loc6_.ConfigValue))
            {
               _loc3_ = parseInt(_loc6_.ConfigValue) / 1000;
            }
            _loc8_ = DateFormatter.parse(_data.bornTime,"YYYY-MM-DD hh:mm:ss").time / 1000;
            _loc8_ = playerModel.sysCurTimeBySecond - _loc8_;
            if(_loc8_ < 1)
            {
               _loc8_ = 1;
            }
            if(_loc8_ > _loc3_)
            {
               _loc8_ = _loc3_;
            }
            _progress.setData(int(_loc8_ * 100 / _loc3_),100);
         }
         else
         {
            _childEquipList.visible = true;
            _progress.visible = false;
            _progressBg.visible = false;
            _progressTxt.visible = false;
            if(_data.job > 0)
            {
               _bg.setFrame(4);
            }
            else
            {
               _bg.setFrame(4);
            }
            if(_data.equipList && _data.equipList.length)
            {
               _loc2_ = _data.equipList;
            }
            else
            {
               _loc2_ = GoodsManager.instance.getChildEquipListById(_data.childId);
            }
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc5_ = _loc2_[_loc4_] as GoodsInfo;
               this["_equip" + _loc5_.pos].data = _loc5_;
               _loc4_++;
            }
            NumberViewUtils.refreshValue(_data.fightValue,_fightSp,_fightBmd,21,29,16,21,"0123456789");
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set isEnterWar(param1:Boolean) : void
      {
         _isEnterWar = param1;
      }
      
      public function get isEnterWar() : Boolean
      {
         return _isEnterWar;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_childAvatar);
         _childAvatar = null;
         ObjectUtils.disposeObject(_childEquipList);
         _childEquipList = null;
         ObjectUtils.disposeObject(_fightImg);
         _fightImg = null;
         ObjectUtils.disposeObject(_fightBmd);
         _fightBmd = null;
         ObjectUtils.disposeObject(_fightSp);
         _fightSp = null;
         ObjectUtils.disposeObject(_equip0);
         _equip0 = null;
         ObjectUtils.disposeObject(_equip1);
         _equip1 = null;
         ObjectUtils.disposeObject(_equip2);
         _equip2 = null;
         ObjectUtils.disposeObject(_equip3);
         _equip3 = null;
         ObjectUtils.disposeObject(_equip4);
         _equip4 = null;
         ObjectUtils.disposeObject(_equip5);
         _equip5 = null;
         ObjectUtils.disposeObject(_equip6);
         _equip6 = null;
         ObjectUtils.disposeObject(_equip7);
         _equip7 = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_progressBg);
         _progressBg = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_gradeImg);
         _gradeImg = null;
         ObjectUtils.disposeObject(_levelText);
         _levelText = null;
         _data = null;
         super.dispose();
      }
   }
}

