package mounts
{
   import com.greensock.TimelineLite;
   import com.greensock.TweenMax;
   import com.greensock.core.TweenCore;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import managers.MountsManager;
   import mvc.module.mounts.MountInfo;
   import mvc.module.mounts.MountRefiningSoulInfo;
   import mvc.module.mounts.PropertyInfo;
   import yishi.datas.ConfigInfoManager;
   
   public class PropertyItem extends Component implements Disposeable, ISelectable
   {
      
      private var _data:MountInfo;
      
      private var _itemBg:Bitmap;
      
      private var _selectedBorder:Bitmap;
      
      private var _gradeBar:MovieClip;
      
      private var _checkBox:SelectedIconButton;
      
      private var _additionTxt:FilterFrameText;
      
      private var _nextAdditionTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _type:String;
      
      private var _levelupMc:MovieClip;
      
      private var frameIndex:int;
      
      private var _curGrade:int = -1;
      
      private var _oldGp:int = 0;
      
      private var _tweenCore:TweenCore;
      
      public function PropertyItem(param1:String)
      {
         super();
         _type = param1;
         initView();
         this.buttonMode = true;
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatBitmap("asset.mounts.PropertyItemBg");
         _selectedBorder = ComponentFactory.Instance.creatBitmap("asset.mounts.SelecedBorder");
         var _loc1_:String = "mounts." + type + "Btn";
         _checkBox = ComponentFactory.Instance.creatComponentByStylename(_loc1_);
         _additionTxt = ComponentFactory.Instance.creatComponentByStylename("mounts.AdditionText");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("mounts.PropertyGradeText");
         _nextAdditionTxt = ComponentFactory.Instance.creatComponentByStylename("mounts.AdditionText");
         _levelupMc = ComponentFactory.Instance.creat("mounts.PropLevelupmc");
         _levelupMc["pre_txt"].addChild(_additionTxt);
         _levelupMc["next_txt"].addChild(_nextAdditionTxt);
         _levelupMc.gotoAndStop(1);
         _levelupMc.x = 111;
         _gradeBar = ComponentFactory.Instance.creatCustomObject("mounts.PropertyGradeBar");
         _gradeBar["halo"].visible = false;
         _selectedBorder.visible = false;
         addChild(_itemBg);
         addChild(_selectedBorder);
         addChild(_checkBox);
         addChild(_levelupMc);
         addChild(_gradeBar);
         addChild(_gradeTxt);
      }
      
      private function uinitView() : void
      {
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_selectedBorder);
         _selectedBorder = null;
         ObjectUtils.disposeObject(_checkBox);
         _checkBox = null;
         ObjectUtils.disposeObject(_additionTxt);
         _additionTxt = null;
         ObjectUtils.disposeObject(_nextAdditionTxt);
         _nextAdditionTxt = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_levelupMc);
         _levelupMc = null;
         ObjectUtils.disposeObject(_gradeBar);
         _gradeBar = null;
      }
      
      public function get data() : MountInfo
      {
         return _data;
      }
      
      public function set data(param1:MountInfo) : void
      {
         _data = param1;
         frameIndex = Math.max(1,Math.min(100,int(propertyInfo.currentPropGp * 100 / propertyInfo.currentPropMaxGp)));
         _curGrade = propertyInfo.grade;
         _additionTxt.text = "+" + totalValue;
         this.tipData = propertyInfo;
         _gradeBar.gotoAndStop(frameIndex);
         _oldGp = propertyInfo.currentPropGp;
         update();
      }
      
      private function get totalValue() : int
      {
         var _loc3_:int = int(ConfigInfoManager.instance.getMountRefiningSoulMaxValue());
         var _loc4_:int = Math.ceil(data.getProperty(type).addition * refiningSoulInfo.getSkillAddPercent() / 100);
         var _loc2_:int = Math.min(_loc4_,_loc3_);
         var _loc5_:int = int(refiningSoulInfo.getPropAddPercentByPropName(type));
         var _loc1_:int = Math.ceil(_loc2_ * _loc5_ / 100);
         return propertyInfo.addition + _loc1_;
      }
      
      public function get propertyInfo() : PropertyInfo
      {
         return _data.getProperty(type);
      }
      
      public function update() : void
      {
         var nextAddition:String;
         var timerId:int;
         var duration:Number;
         var timeline:TimelineLite;
         disposeTween();
         nextAddition = "+" + totalValue;
         if(_additionTxt.text != nextAddition)
         {
            _nextAdditionTxt.text = nextAddition;
            _levelupMc.gotoAndPlay(1);
         }
         timerId = int(setTimeout(function():void
         {
            clearTimeout(timerId);
            _additionTxt && (_additionTxt.text = nextAddition);
         },700));
         _gradeTxt.text = propertyInfo.currentPropGp + " / " + propertyInfo.currentPropMaxGp;
         frameIndex = Math.max(1,Math.min(100,int(propertyInfo.currentPropGp * 100 / propertyInfo.currentPropMaxGp)));
         duration = 0.3;
         if(propertyInfo.grade == _curGrade || Boolean(propertyInfo.isLimit))
         {
            if(frameIndex != _gradeBar.currentFrame)
            {
               _gradeBar["halo"].visible = true;
               duration = frameIndex - _gradeBar.currentFrame > 25 ? 0.8 : 0.3;
               _tweenCore = TweenMax.to(_gradeBar,duration,{
                  "frame":frameIndex,
                  "onComplete":__onFinishTween
               });
            }
            else if(_oldGp != propertyInfo.currentPropGp)
            {
               _gradeBar["halo"].visible = true;
               _tweenCore = TweenMax.to(_gradeBar,0.3,{
                  "frame":frameIndex,
                  "onComplete":__onFinishTween
               });
            }
         }
         else if(propertyInfo.grade != _curGrade)
         {
            _gradeBar["halo"].visible = true;
            timeline = new TimelineLite({"onComplete":__onFinishTween});
            duration = 100 - _gradeBar.currentFrame > 25 ? 0.8 : 0.3;
            timeline.append(TweenMax.to(_gradeBar,duration,{"frame":100}));
            duration = frameIndex > 25 ? 0.8 : 0.3;
            timeline.append(TweenMax.fromTo(_gradeBar,duration,{"frame":1},{"frame":frameIndex}));
            timeline.play();
            _tweenCore = timeline;
            timeline = null;
         }
         _curGrade = propertyInfo.grade;
         _oldGp = propertyInfo.currentPropGp;
      }
      
      private function __onFinishTween() : void
      {
         disposeTween();
      }
      
      public function get checkBox() : SelectedIconButton
      {
         return this._checkBox;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
         this._checkBox.autoSelect = param1;
      }
      
      public function get selected() : Boolean
      {
         return _checkBox.selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _checkBox.selected = param1;
         if(param1)
         {
            this._selectedBorder.visible = true;
         }
         else
         {
            this._selectedBorder.visible = false;
         }
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      private function disposeTween() : void
      {
         if(_tweenCore)
         {
            _tweenCore.kill();
            _tweenCore = null;
         }
         _gradeBar && (_gradeBar["halo"].visible = false);
      }
      
      private function get refiningSoulInfo() : MountRefiningSoulInfo
      {
         return MountsManager.instance.selfRefiningSoulInfo;
      }
      
      override public function dispose() : void
      {
         if(!isDie)
         {
            disposeTween();
            uinitView();
            _data = null;
            super.dispose();
         }
      }
   }
}

