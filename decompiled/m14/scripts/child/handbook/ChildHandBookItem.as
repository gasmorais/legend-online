package child.handbook
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildCollectInfo;
   import mvc.module.children.ChildModel;
   import org.bytearray.display.ScaleBitmap;
   import yishi.datas.VersionSwitch;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.ChildTypeTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.StarBar;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildHandBookItem extends Component implements ISelectable, IManualSize
   {
      
      private var itemContiner:Component;
      
      private var back:Bitmap;
      
      private var selectedbg:Bitmap;
      
      private var canvas:ScaleBitmap;
      
      private var typeText:FilterFrameText;
      
      private var noAlertText:FilterFrameText;
      
      private var growthText:FilterFrameText;
      
      private var callBtn:TextButton;
      
      private var starBox:StarBar;
      
      private var starUpBtn:BaseButton;
      
      private var awakeBtn:IconButton;
      
      private var _isSelected:Boolean;
      
      private const starCount:int = 5;
      
      private var _data:ChildTempInfo;
      
      private var _collectInfo:ChildCollectInfo;
      
      private var curTypeTemp:ChildTypeTempInfo;
      
      public function ChildHandBookItem()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(back)
         {
            return back.getRect(this);
         }
         return new Rectangle(10,10,162,158);
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatBitmap("asset.ChildHandBookItem.back");
         selectedbg = ComponentFactory.Instance.creatBitmap("asset.ChildHandBookItem.SelectedBg");
         typeText = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookItem.typeText");
         noAlertText = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookItem.noAlertText");
         growthText = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookItem.growthText");
         callBtn = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookItem.callBtn");
         starUpBtn = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookItem.starUpBtn");
         awakeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookItem.awakeBtn");
         itemContiner = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookItem.itemContiner");
         canvas = new ScaleBitmap(new BitmapData(1,1,true,0));
         starBox = new StarBar(5,0,"asset.ChildHandBookItem.EmptyStar","asset.ChildHandBookItem.FullStar");
         starBox.tipStyle = "yishi.view.tips.OneLineTip";
         starBox.isFollowMouse = false;
         starBox.tipDirctions = "7,5,4,6";
         starBox.tipGapH = 0;
         starBox.tipGapV = 0;
         starBox.x = 20;
         starBox.y = 153;
         itemContiner.addChild(back);
         itemContiner.addChild(selectedbg);
         selectedbg.visible = false;
         itemContiner.addChild(canvas);
         itemContiner.addChild(typeText);
         itemContiner.addChild(noAlertText);
         itemContiner.addChild(growthText);
         itemContiner.addChild(starBox);
         itemContiner.addChild(starUpBtn);
         itemContiner.addChild(awakeBtn);
         addChild(itemContiner);
         addChild(callBtn);
         callBtn.text = LanguageMgr.GetTranslation("ChildHandBookItem.callBtn.text");
      }
      
      private function addEvent() : void
      {
         callBtn.addEventListener("click",__callBtnHandler);
         starUpBtn.addEventListener("click",__awakeUpgradeBtnHandler);
         awakeBtn.addEventListener("click",__awakeUpgradeBtnHandler);
         addEventListener("click",__itemClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(callBtn)
         {
            callBtn.removeEventListener("click",__callBtnHandler);
         }
         if(starUpBtn)
         {
            starUpBtn.removeEventListener("click",__awakeUpgradeBtnHandler);
         }
         if(awakeBtn)
         {
            awakeBtn.removeEventListener("click",__awakeUpgradeBtnHandler);
         }
         removeEventListener("click",__itemClickHandler);
      }
      
      protected function __itemClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         model.selectedChildTemp = data;
      }
      
      private function __callBtnHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         if(model.getChildTypeList(data.JobType).length >= 8)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildHandBookItem.ChildCallAlert.childFull"));
            return;
         }
         var _loc2_:ChildCallAlertFrame = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookItem.ChildCallAlertFrame");
         _loc2_.data = data;
         _loc2_.show();
      }
      
      private function __awakeUpgradeBtnHandler(param1:MouseEvent) : void
      {
         var _loc3_:ChildTypeTempInfo = null;
         if(!VersionSwitch.CHILD_SLAVED)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
            return;
         }
         if(data && _collectInfo)
         {
            _loc3_ = TempleteManager.instance.childTypeTemplateCate.getTemplateByJobAndSoulWakeGrades(_data.JobType,_collectInfo.soulWakes + 1);
         }
         if(!_loc3_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildHandBookItem.awakeUpgrade.isFull"));
            return;
         }
         var _loc2_:ChildAwakeUpgradeAlertFrame = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookItem.ChildAwakeAlertFrame");
         _loc2_.data = data;
         _loc2_.show();
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _isSelected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _isSelected = param1;
         selectedbg.visible = _isSelected;
      }
      
      public function get rect() : Rectangle
      {
         return new Rectangle(0,0,165,161);
      }
      
      public function get data() : ChildTempInfo
      {
         return _data;
      }
      
      public function set data(param1:ChildTempInfo) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         clear();
         _data = param1;
         if(_data)
         {
            typeText.text = _data.JobName;
            callBtn.visible = true;
            this.buttonMode = true;
            _collectInfo = model.getChildCollecInfoByType(_data.JobType);
            if(_collectInfo && model.getChildTypeList(_data.JobType).length > 0)
            {
               curTypeTemp = TempleteManager.instance.childTypeTemplateCate.getTemplateByJobAndSoulWakeGrades(_data.JobType,_collectInfo.soulWakes);
               growthText.htmlText = LanguageMgr.GetTranslation("ChildHandBookItem.growthText.text",_collectInfo.growth);
               itemContiner.filters = [];
               _loc2_ = int(curTypeTemp ? curTypeTemp.Percentage : 0);
               if(_collectInfo.soulWakes > 0)
               {
                  starUpBtn.visible = true;
                  starBox.visible = true;
                  starBox.progress = _collectInfo.soulWakes;
               }
               else
               {
                  awakeBtn.visible = true;
               }
               starBox.tipData = LanguageMgr.GetTranslation("ChildHandBookItem.starBox.tipData",_loc2_);
            }
            else
            {
               noAlertText.text = LanguageMgr.GetTranslation("ChildHandBookItem.noAlertText.text");
            }
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onLoaded);
            _loc3_ = PathManager.getChildShowByJobAndGrade(_data.JobType,_data.Grades);
            LoaderManagerII.instance.load(_loc3_,2,8,__onLoaded);
         }
      }
      
      private function __onLoaded(param1:LoaderInfo, param2:Object) : void
      {
         var _loc5_:BitmapData = null;
         var _loc6_:Matrix = null;
         var _loc3_:Rectangle = null;
         if(isDie || !data)
         {
            return;
         }
         var _loc4_:MovieClip = param2 as MovieClip;
         if(_loc4_)
         {
            _loc4_.gotoAndStop(_loc4_.totalFrames - 1);
            _loc5_ = new BitmapData(500,500,true,0);
            _loc6_ = new Matrix();
            _loc6_.ty = 50;
            _loc5_.draw(_loc4_,_loc6_);
            _loc3_ = _loc5_.getColorBoundsRect(4278190080,0,false);
            canvas.bitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            canvas.bitmapData.copyPixels(_loc5_,_loc3_,new Point(),null,null,true);
            canvas.width = _loc3_.width * 0.5;
            canvas.height = _loc3_.height * 0.5;
            _loc5_.dispose();
            canvas.x = int((190 - canvas.width) / 2);
            canvas.y = 20;
         }
         _loc4_ = null;
      }
      
      private function clear() : void
      {
         typeText.text = "";
         growthText.text = "";
         noAlertText.text = "";
         this.canvas.bitmapData.dispose();
         callBtn.visible = false;
         awakeBtn.visible = false;
         starUpBtn.visible = false;
         starBox.visible = false;
         this.buttonMode = false;
         itemContiner.filters = [UIFilter.getGrayFilter()];
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(selectedbg);
         selectedbg = null;
         ObjectUtils.disposeObject(canvas);
         canvas = null;
         ObjectUtils.disposeObject(typeText);
         typeText = null;
         ObjectUtils.disposeObject(noAlertText);
         noAlertText = null;
         ObjectUtils.disposeObject(growthText);
         growthText = null;
         ObjectUtils.disposeObject(starBox);
         starBox = null;
         ObjectUtils.disposeObject(starUpBtn);
         starUpBtn = null;
         ObjectUtils.disposeObject(awakeBtn);
         awakeBtn = null;
         ObjectUtils.disposeObject(callBtn);
         callBtn = null;
         ObjectUtils.disposeObject(itemContiner);
         itemContiner = null;
         super.dispose();
      }
   }
}

