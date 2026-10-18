package faterotary
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.FateGuardEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.faterotary.FateRotarySkillInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.base.Progress;
   import yishi.view.community.BaseIconView;
   
   public class FateRotarySkillItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _back1:MutipleImage;
      
      private var _back2:Image;
      
      private var _back3:Image;
      
      private var _arrow:Image;
      
      private var _splice:Image;
      
      private var _costBack:Image;
      
      private var _new:Image;
      
      private var _old:Image;
      
      private var _hit1:BaseIconView;
      
      private var _Lv:Image;
      
      private var _lvTxt:FilterFrameText;
      
      private var _exp1Back:ScaleLeftRightImage;
      
      private var _exp1:Progress;
      
      private var _nextEffectGrade:FilterFrameText;
      
      private var _costTxt:FilterFrameText;
      
      private var _costValue:FilterFrameText;
      
      private var _oldAttribute:FilterFrameText;
      
      private var _newAttribute:FilterFrameText;
      
      private var _fateStoneIcon:Image;
      
      private var _trainBtn:IconButton;
      
      private var _unOpen1:Image;
      
      private var _remainTxt:FilterFrameText;
      
      private var _selected:Boolean;
      
      private var _thane:ThaneInfo;
      
      private var _firstSkill:FateRotarySkillInfo;
      
      public var index:int = 0;
      
      public var _stoneNumMc:MovieClip;
      
      private var _allPointImgs:Array;
      
      private var _allNextPointImgs:Array;
      
      private var stoneTempId:int = 0;
      
      private var stoneCount:int = -1;
      
      public function FateRotarySkillItem(param1:int, param2:int)
      {
         super();
         index = param1;
         stoneTempId = param2;
         _thane = ArmyManager.instance.thane;
         initView();
         buttonMode = true;
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("faterotary.FrameBorder");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("faterotary.FrameBack2");
         _back3 = ComponentFactory.Instance.creatComponentByStylename("faterotary.FrameBack3");
         _arrow = ComponentFactory.Instance.creatComponentByStylename("faterotary.Arrow");
         _splice = ComponentFactory.Instance.creatComponentByStylename("faterotary.SpliceLine");
         _costBack = ComponentFactory.Instance.creatComponentByStylename("faterotary.CostBack");
         _new = ComponentFactory.Instance.creatComponentByStylename("faterotary.NewAttribute");
         _old = ComponentFactory.Instance.creatComponentByStylename("faterotary.OldAttribute");
         _fateStoneIcon = ComponentFactory.Instance.creatComponentByStylename("faterotary.FateStoneIcon_" + (index + 1));
         _nextEffectGrade = ComponentFactory.Instance.creatComponentByStylename("faterotary.GetStoneTxt_1");
         _nextEffectGrade.visible = false;
         _costTxt = ComponentFactory.Instance.creatComponentByStylename("faterotary.CostTxt");
         _costValue = ComponentFactory.Instance.creatComponentByStylename("faterotary.CostValue");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("faterotary.LVValue");
         _oldAttribute = ComponentFactory.Instance.creatComponentByStylename("faterotary.OldValue");
         _newAttribute = ComponentFactory.Instance.creatComponentByStylename("faterotary.NewValue");
         _Lv = ComponentFactory.Instance.creatComponentByStylename("faterotary.LVIcon_1");
         _hit1 = ComponentFactory.Instance.creatCustomObject("faterotary.SkillIcon");
         _exp1Back = ComponentFactory.Instance.creatComponentByStylename("faterotary.FateSkillExp_ProgressBack");
         _exp1 = ComponentFactory.Instance.creatCustomObject("faterotary.FateSkillExp_1");
         _trainBtn = ComponentFactory.Instance.creatComponentByStylename("faterotary.TrainBtn");
         _unOpen1 = ComponentFactory.Instance.creatComponentByStylename("faterotary.UnOpenTxt_1");
         _costTxt.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelCostTxt");
         _remainTxt = ComponentFactory.Instance.creatComponentByStylename("fateRotarySkillItem.remainTxt");
         _stoneNumMc = ComponentFactory.Instance.creat("faterotary.GetEffect");
         addChild(_back3);
         addChild(_Lv);
         addChild(_hit1);
         addChild(_lvTxt);
         addChild(_exp1Back);
         addChild(_exp1);
         _remainTxt.htmlText = LanguageMgr.GetTranslation("fateRotarySkillItem.remainNum","");
         var _loc1_:int = FateRotaryFrame.getStoneId(index);
         _fateStoneIcon.tipData = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc1_).TemplateName + "," + TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc1_).Description;
      }
      
      private function initEvent() : void
      {
         _costValue.addEventListener("change",__textChangeHandler);
         _trainBtn.addEventListener("click",__trainHandler);
         _firstSkill.addEventListener("fategpchange",__skillChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _costValue.removeEventListener("change",__textChangeHandler);
         _trainBtn.removeEventListener("click",__trainHandler);
         if(_firstSkill)
         {
            _firstSkill.removeEventListener("fategpchange",__skillChangeHandler);
         }
      }
      
      private function __skillChangeHandler(param1:FateGuardEvent) : void
      {
         refreshRunCircleView();
         FrameControllerManager.instance.fateRotaryControler.frame["refreshRunCircleView"]();
      }
      
      private function __trainHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.fateRotaryControler.traintFateGuardSkill(_firstSkill.fateTypes,int(_costValue.text));
      }
      
      private function __textChangeHandler(param1:Event) : void
      {
         var _loc3_:int = int(GoodsManager.instance.getGoodsNumByTempId(stoneTempId));
         _trainBtn.enable = _loc3_ > 0;
         var _loc4_:int = parseInt(_costValue.text);
         if(_loc4_ >= _loc3_)
         {
            _loc4_ = _loc3_;
         }
         _costValue.text = _loc4_.toString();
         var _loc2_:UpgradeTemplateInfo = _firstSkill.nextUpgradeTemp;
         _trainBtn.enable = _loc4_ > 0 && _loc2_;
      }
      
      public function set data(param1:FateRotarySkillInfo) : void
      {
         _firstSkill = param1;
         if(!_firstSkill)
         {
            selected = false;
            addChild(_unOpen1);
            _Lv.visible = false;
            _hit1.visible = false;
            _lvTxt.visible = false;
            _exp1Back.visible = false;
            _exp1.visible = false;
            buttonMode = false;
            filters = [ComponentFactory.Instance.model.getSet("core.GrayFilter")];
         }
         else
         {
            initEvent();
         }
      }
      
      public function get data() : FateRotarySkillInfo
      {
         return _firstSkill;
      }
      
      public function getFlyTarget() : Point
      {
         if(_stoneNumMc)
         {
            return _stoneNumMc.localToGlobal(new Point());
         }
         return new Point();
      }
      
      public function playAddMovie() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = int(GoodsManager.instance.getGoodsNumByTempId(stoneTempId));
         if(stoneCount == -1)
         {
            stoneCount = _loc2_;
         }
         if(_stoneNumMc)
         {
            _loc1_ = _loc2_ - stoneCount;
            if(_loc1_ > 0)
            {
               _stoneNumMc["effect"]["txt"].text = "+" + _loc1_;
               _stoneNumMc.play();
            }
         }
      }
      
      public function removeAllNextPoints() : void
      {
         var _loc1_:int = 0;
         if(_allNextPointImgs)
         {
            _loc1_ = 0;
            while(_loc1_ < _allNextPointImgs.length)
            {
               _allNextPointImgs[_loc1_] && _allNextPointImgs[_loc1_].parent && _allNextPointImgs[_loc1_].parent.removeChild(_allNextPointImgs[_loc1_]);
               _loc1_++;
            }
         }
      }
      
      public function refreshRunCircleView() : void
      {
         var _loc6_:SkillTempInfo = null;
         var _loc4_:UpgradeTemplateInfo = null;
         if(!_firstSkill)
         {
            return;
         }
         var _loc2_:SkillTempInfo = _firstSkill.template;
         var _loc1_:UpgradeTemplateInfo = _firstSkill.nextUpgradeTemp;
         _lvTxt.text = _firstSkill.grades.toString();
         _hit1.icon = IconFactory.getCommonIconPath(_loc2_.Icons);
         _hit1.tipData = _loc2_.TemplateName + "   " + LanguageMgr.GetTranslation("public.grade") + "  " + _firstSkill.grades;
         if(_loc1_)
         {
            _loc6_ = TempleteManager.instance.getSkillTemplateInfoById(_loc1_.TemplateId);
            _newAttribute.htmlText = _loc6_.Description;
            _newAttribute.x = 240;
            _exp1.setData(_firstSkill.currentGp,_loc1_.Data);
         }
         else
         {
            _newAttribute.htmlText = LanguageMgr.GetTranslation("faterotary.LevelMax");
            _newAttribute.x = 250;
            _loc4_ = TempleteManager.instance.getTemplateByLevelAndType(_firstSkill.grades,_firstSkill.upgradeType);
            _exp1.setData(_loc4_.Data,_loc4_.Data);
         }
         var _loc3_:int = int(GoodsManager.instance.getGoodsNumByTempId(stoneTempId));
         if(_stoneNumMc)
         {
            _stoneNumMc["content"]["txt"].text = _loc3_.toString();
         }
         _trainBtn.enable = _loc1_ && _loc3_ > 0;
         _costValue.text = _loc3_.toString();
         stoneCount = _loc3_;
         if(_loc2_.Description)
         {
            _oldAttribute.htmlText = _loc2_.Description;
            _oldAttribute.x = 31;
         }
         else
         {
            _oldAttribute.htmlText = LanguageMgr.GetTranslation("faterotary.LevelMin");
            _oldAttribute.x = 50;
         }
         var _loc5_:int = getMaxGrade();
         if(_loc5_ < 15)
         {
            _newAttribute.y = 110 + (100 - _newAttribute.textHeight) * 0.5;
            _oldAttribute.y = 110 + (100 - _oldAttribute.textHeight) * 0.5;
            _arrow.y = 105 + (100 - _arrow.height) * 0.5;
            _nextEffectGrade.htmlText = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.GetFateStone1",(int(_loc5_ / 5) + 1) * 5);
            _splice.visible = true;
         }
         else
         {
            _newAttribute.y = 110 + (100 - _newAttribute.textHeight) * 0.5;
            _oldAttribute.y = 110 + (100 - _oldAttribute.textHeight) * 0.5;
            _arrow.y = 105 + (100 - _arrow.height) * 0.5;
            _nextEffectGrade.htmlText = "";
            _splice.visible = false;
         }
         if(!_allPointImgs)
         {
            _allPointImgs = [];
            if(_loc1_)
            {
               addNewPointImg(_loc6_.Description);
            }
            if(_loc2_.Description)
            {
               addOldPointImg(_loc2_.Description);
            }
         }
      }
      
      private function addOldPointImg(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Array = getEachPropertyLineCount(param1);
         if(!_loc2_ || _loc2_.length == 0)
         {
            return;
         }
         var _loc3_:Number = _oldAttribute.y + 4;
         var _loc5_:Image = ComponentFactory.Instance.creatComponentByStylename("faterotary.point");
         _loc5_.x = _oldAttribute.x - 14;
         _loc5_.y = _loc3_;
         _allPointImgs.push(_loc5_);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length - 1)
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("faterotary.point");
            _loc5_.x = _oldAttribute.x - 14;
            _loc3_ += _loc2_[_loc4_] * 16;
            _loc5_.y = _loc3_;
            _allPointImgs.push(_loc5_);
            _loc4_++;
         }
      }
      
      private function addNewPointImg(param1:String) : void
      {
         var _loc4_:int = 0;
         if(!_allNextPointImgs)
         {
            _allNextPointImgs = [];
         }
         var _loc2_:Array = getEachPropertyLineCount(param1);
         if(!_loc2_ || _loc2_.length == 0)
         {
            return;
         }
         var _loc3_:Number = _newAttribute.y + 4;
         var _loc5_:Image = ComponentFactory.Instance.creatComponentByStylename("faterotary.point");
         _loc5_.x = _newAttribute.x - 14;
         _loc5_.y = _loc3_;
         _allPointImgs.push(_loc5_);
         _allNextPointImgs.push(_loc5_);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length - 1)
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("faterotary.point");
            _loc5_.x = _newAttribute.x - 14;
            _loc3_ += _loc2_[_loc4_] * 20;
            _loc5_.y = _loc3_;
            _allPointImgs.push(_loc5_);
            _allNextPointImgs.push(_loc5_);
            _loc4_++;
         }
      }
      
      private function getEachPropertyLineCount(param1:String) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("faterotary.NewValue");
         var _loc4_:Array = param1.split("<br>");
         var _loc2_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_.htmlText = _loc4_[_loc5_];
            _loc2_.push(_loc3_.numLines);
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function getMaxGrade() : int
      {
         var _loc1_:Vector.<FateRotarySkillInfo> = ArmyManager.instance.thane.fateRotarySkillList;
         var _loc2_:int = 0;
         for each(var _loc3_:FateRotarySkillInfo in _loc1_)
         {
            if(_loc3_.grades > _loc2_)
            {
               _loc2_ = int(_loc3_.grades);
            }
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_old);
         _old = null;
         ObjectUtils.disposeObject(_new);
         _new = null;
         ObjectUtils.disposeObject(_costBack);
         _costBack = null;
         ObjectUtils.disposeObject(_splice);
         _splice = null;
         ObjectUtils.disposeObject(_arrow);
         _arrow = null;
         ObjectUtils.disposeObject(_back3);
         _back3 = null;
         ObjectUtils.disposeObject(_oldAttribute);
         _oldAttribute = null;
         ObjectUtils.disposeObject(_costValue);
         _costValue = null;
         ObjectUtils.disposeObject(_costTxt);
         _costTxt = null;
         ObjectUtils.disposeObject(_nextEffectGrade);
         _nextEffectGrade = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_Lv);
         _Lv = null;
         ObjectUtils.disposeObject(_hit1);
         _hit1 = null;
         ObjectUtils.disposeObject(_exp1);
         _exp1 = null;
         ObjectUtils.disposeObject(_exp1Back);
         _exp1Back = null;
         ObjectUtils.disposeObject(_fateStoneIcon);
         _fateStoneIcon = null;
         ObjectUtils.disposeObject(_trainBtn);
         _trainBtn = null;
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         _thane = null;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         var _loc4_:Image = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         if(_selected)
         {
            addChild(_back1);
            addChild(_back2);
            if(_back3.parent)
            {
               _back3.parent.removeChild(_back3);
            }
            addChild(_arrow);
            addChild(_splice);
            addChild(_costBack);
            addChild(_new);
            addChild(_old);
            addChild(_Lv);
            addChild(_oldAttribute);
            addChild(_newAttribute);
            addChild(_hit1);
            addChild(_lvTxt);
            addChild(_fateStoneIcon);
            addChild(_costTxt);
            addChild(_costValue);
            addChild(_exp1Back);
            addChild(_exp1);
            addChild(_trainBtn);
            addChild(_remainTxt);
            addChild(_stoneNumMc);
            if(_allPointImgs)
            {
               _loc2_ = 0;
               while(_loc2_ < _allPointImgs.length)
               {
                  if(_allPointImgs[_loc2_])
                  {
                     _loc4_ = _allPointImgs[_loc2_] as Image;
                     addChild(_loc4_);
                  }
                  _loc2_++;
               }
            }
            buttonMode = false;
         }
         else
         {
            if(_back1.parent)
            {
               _back1.parent.removeChild(_back1);
            }
            if(_back2.parent)
            {
               _back2.parent.removeChild(_back2);
            }
            if(_arrow.parent)
            {
               _arrow.parent.removeChild(_arrow);
            }
            if(_splice.parent)
            {
               _splice.parent.removeChild(_splice);
            }
            if(_costBack.parent)
            {
               _costBack.parent.removeChild(_costBack);
            }
            if(_new.parent)
            {
               _new.parent.removeChild(_new);
            }
            if(_old.parent)
            {
               _old.parent.removeChild(_old);
            }
            if(_oldAttribute.parent)
            {
               _oldAttribute.parent.removeChild(_oldAttribute);
            }
            if(_newAttribute.parent)
            {
               _newAttribute.parent.removeChild(_newAttribute);
            }
            if(_nextEffectGrade.parent)
            {
               _nextEffectGrade.parent.removeChild(_nextEffectGrade);
            }
            if(_costTxt.parent)
            {
               _costTxt.parent.removeChild(_costTxt);
            }
            if(_costValue.parent)
            {
               _costValue.parent.removeChild(_costValue);
            }
            if(_fateStoneIcon.parent)
            {
               _fateStoneIcon.parent.removeChild(_fateStoneIcon);
            }
            if(_trainBtn.parent)
            {
               _trainBtn.parent.removeChild(_trainBtn);
            }
            if(_remainTxt.parent)
            {
               _remainTxt.parent.removeChild(_remainTxt);
            }
            if(_stoneNumMc.parent)
            {
               _stoneNumMc.parent.removeChild(_stoneNumMc);
            }
            if(_allPointImgs)
            {
               _loc3_ = 0;
               while(_loc3_ < _allPointImgs.length)
               {
                  _allPointImgs[_loc3_] && _allPointImgs[_loc3_].parent && _allPointImgs[_loc3_].parent.removeChild(_allPointImgs[_loc3_]);
                  _loc3_++;
               }
            }
            addChild(_back3);
            addChild(_Lv);
            addChild(_hit1);
            addChild(_lvTxt);
            addChild(_exp1Back);
            addChild(_exp1);
            buttonMode = true;
         }
      }
   }
}

