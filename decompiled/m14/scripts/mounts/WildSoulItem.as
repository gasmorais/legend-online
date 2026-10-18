package mounts
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
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import mvc.module.mounts.MountInfo;
   import mvc.module.mounts.WildSoulCollection;
   import mvc.module.mounts.WildSoulInfo;
   import mvc.module.vip.VIPModel;
   import org.bytearray.display.ScaleBitmap;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MountAvatarPathHelper;
   import yishi.view.base.StarBar;
   
   public class WildSoulItem extends Component implements ISelectable, Disposeable, IManualSize
   {
      
      private var _data:MountTemplate;
      
      private var _isSelected:Boolean;
      
      private var _isLock:Boolean;
      
      private var _bg:ScaleFrameImage;
      
      private var _overBg:Bitmap;
      
      private var _selectedbg:Bitmap;
      
      private var _vipFlag:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _lock:Bitmap;
      
      private var _canvas:ScaleBitmap;
      
      private var _hitSprite:Sprite;
      
      private const starCount:int = 5;
      
      private var _promotBtn:BaseButton;
      
      private var _starBox:StarBar;
      
      private var _flashMc:MovieClip;
      
      private var _descTxt:FilterFrameText;
      
      private var _countDownTxt:FilterFrameText;
      
      private var _kingBoard:Image;
      
      private var _kingTrainBtn:IconButton;
      
      private var _getBtn:TextButton;
      
      public function WildSoulItem()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(_bg)
         {
            return _bg.getRect(this);
         }
         return new Rectangle(10,10,162,158);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("mounts.WildSoulItem.ItemBg");
         _kingBoard = ComponentFactory.Instance.creatComponentByStylename("mounts.WildSoulItem.kingBoard");
         _lock = ComponentFactory.Instance.creatBitmap("asset.wildsoul.Lock");
         _overBg = ComponentFactory.Instance.creatBitmap("asset.wildsoul.OverBg");
         _selectedbg = ComponentFactory.Instance.creatBitmap("asset.wildsoul.SelectedBg");
         _vipFlag = ComponentFactory.Instance.creatBitmap("asset.mounts.VIPAsset");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("wildsoul.nameTxt");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("wildsoul.nameGradeTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("wildsoul.descTxt");
         _countDownTxt = ComponentFactory.Instance.creatComponentByStylename("mounts.countDownTxt");
         _kingTrainBtn = ComponentFactory.Instance.creatComponentByStylename("mounts.kingTrainBtn");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("wildsoul.getBtn");
         _canvas = new ScaleBitmap(new BitmapData(1,1,true,0));
         _hitSprite = new Sprite();
         hitArea = _hitSprite;
         _overBg.visible = false;
         _getBtn.text = LanguageMgr.GetTranslation("mounts.Illusion");
         _getBtn.visible = false;
         _selectedbg.visible = false;
         _vipFlag.visible = false;
         addChild(_bg);
         _bg.setFrame(1);
         addChild(_kingBoard);
         _kingBoard.visible = false;
         addChild(_overBg);
         addChild(_selectedbg);
         addChild(_canvas);
         addChild(_vipFlag);
         addChild(_nameTxt);
         addChild(_gradeTxt);
         addChild(_descTxt);
         addChild(_lock);
         addChild(_countDownTxt);
         addChild(_kingTrainBtn);
         addChild(_getBtn);
         _bg.mouseEnabled = _bg.mouseChildren = false;
         _kingBoard.mouseEnabled = _kingBoard.mouseChildren = false;
         _starBox = new StarBar(5,0,"asset.wildsoul.EmptyStar","asset.wildsoul.FullStar");
         _starBox.mouseEnabled = _starBox.mouseChildren = false;
         _starBox.x = 10;
         _starBox.y = 135;
         addChild(_starBox);
         _flashMc = ComponentFactory.Instance.creat("asset.core.TaskRewardButtonMc3");
         _flashMc.gotoAndStop(1);
         _flashMc.pos.mouseEnabled = false;
         _flashMc.mouseEnabled = false;
         _promotBtn = ComponentFactory.Instance.creatComponentByStylename("wildSoulItem.promotBtn");
         _flashMc.pos.addChild(_promotBtn);
         addChild(_flashMc);
         _promotBtn.tipData = LanguageMgr.GetTranslation("refine");
         _nameTxt.cacheAsBitmap = false;
         setHitArea();
         addChild(_hitSprite);
      }
      
      private function addEvent() : void
      {
         _getBtn.addEventListener("click",_getBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",_getBtnHandler);
      }
      
      protected function _getBtnHandler(param1:MouseEvent) : void
      {
         (parent.parent.parent as WildSoulFrame).onChange(parent.getChildIndex(this));
      }
      
      private function setHitArea() : void
      {
         _hitSprite.graphics.clear();
         _hitSprite.graphics.beginFill(0,0);
         _hitSprite.graphics.drawRect(_bg.x,_bg.y,_bg.width,_bg.height);
         _hitSprite.mouseChildren = _hitSprite.mouseEnabled = false;
      }
      
      private function uinitView() : void
      {
         _bg = null;
         _overBg = null;
         _selectedbg = null;
         _canvas = null;
         _nameTxt = null;
         _gradeTxt = null;
         ObjectUtils.disposeAllChildren(_hitSprite);
         ObjectUtils.disposeObject(_hitSprite);
         _hitSprite = null;
         ObjectUtils.disposeObject(_promotBtn);
         _promotBtn = null;
         ObjectUtils.disposeObject(_starBox);
         _starBox = null;
         ObjectUtils.disposeObject(_countDownTxt);
         _countDownTxt = null;
         ObjectUtils.disposeObject(_kingTrainBtn);
         _kingTrainBtn = null;
         if(_lock)
         {
            _lock.bitmapData.dispose();
            _lock.parent && _lock.parent.removeChild(_lock);
            _lock = null;
         }
         if(_canvas)
         {
            _canvas.dispose();
            _canvas.parent && _canvas.parent.removeChild(_canvas);
            _canvas = null;
         }
         ObjectUtils.disposeObject(_flashMc);
         _flashMc = null;
      }
      
      public function mouseOver(param1:MouseEvent = null) : void
      {
         if(!(selected || _isLock))
         {
            this._overBg.visible = true;
            this._getBtn.visible = true;
         }
      }
      
      public function mouseOut(param1:MouseEvent = null) : void
      {
         if(!(selected || _isLock))
         {
            this._overBg.visible = false;
            this._getBtn.visible = false;
         }
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
         _isSelected = _isLock == true ? false : param1;
         if(selected)
         {
            this._selectedbg.visible = true;
            this._overBg.visible = false;
         }
         else
         {
            this._selectedbg.visible = false;
            this._overBg.visible = false;
         }
      }
      
      public function get rect() : Rectangle
      {
         return new Rectangle(0,0,165,161);
      }
      
      public function get data() : MountTemplate
      {
         return _data;
      }
      
      public function set data(param1:MountTemplate) : void
      {
         _data = param1;
         clear();
         _countDownTxt.visible = false;
         if(!_data || _data.MountType == 0 && _data.Property2 - mountInfo.grade > 1)
         {
            this.tipData = LanguageMgr.GetTranslation("mounts.WildsoulItem.tipsNoOpen");
            return;
         }
         _bg.setFrame(1);
         _kingBoard.visible = false;
         if(_data.MountType == 0)
         {
            _nameTxt.setFrame(2);
            if(_nameTxt.text != _data.TemplateName)
            {
               _nameTxt.text = _data.TemplateName;
               _gradeTxt.x = _nameTxt.x + _nameTxt.textWidth + 4;
            }
            _gradeTxt.text = LanguageMgr.GetTranslation("mounts.command01",_data.Property2);
         }
         else
         {
            if(_data.MountType == 4)
            {
               _bg.setFrame(2);
               _kingBoard.visible = true;
               _kingTrainBtn.visible = true;
            }
            _nameTxt.text = _data.TemplateName;
         }
         if(_data.MountType == 1 || isLock)
         {
            this.tipData = _data;
         }
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onLoaded);
         var _loc2_:String = MountAvatarPathHelper.getUrl(_data.AvatarPath);
         LoaderManagerII.instance.load(_loc2_,2,8,__onLoaded);
         if(wildSoulCollection.isLightTemplate(_data.TemplateId))
         {
            unlock();
         }
         if(_data.MountType == 3)
         {
            _vipFlag.visible = true;
         }
         var _loc3_:WildSoulInfo = wildSoulCollection.getWildSoulInfo(_data.TemplateId);
         if(_loc3_)
         {
            _starBox.progress = _loc3_.star;
            _starBox.count = _loc3_.template.maxStarGrade;
            _starBox.x = 150 - _starBox.width >> 1;
            if(_starBox.count == 4)
            {
               _starBox.x = 23;
            }
            else if(_starBox.count == 5)
            {
               _starBox.x = 10;
            }
         }
         if(ArmyManager.instance.thane.grades >= 70 && Boolean(MountsManager.instance.canShowStar(_data.TemplateId)) && _data.MountType != 4)
         {
            _starBox.visible = _promotBtn.visible = true;
         }
         else
         {
            _starBox.visible = _promotBtn.visible = false;
         }
         if(!_starBox.visible)
         {
            if(_data.MountType == 3 || _loc3_ && _loc3_.validity != -1)
            {
               _descTxt.text = LanguageMgr.GetTranslation("warlords.WarlordsCheckRewardFrame.str05");
            }
            else if(isLock)
            {
               _descTxt.text = LanguageMgr.GetTranslation("notBeActivated");
            }
            if(isLock)
            {
               _descTxt.setFrame(2);
            }
            else
            {
               _descTxt.setFrame(1);
            }
         }
         showDescTime();
      }
      
      public function showDescTime() : void
      {
         var _loc3_:GoodsTemplateInfo = null;
         var _loc11_:WildSoulInfo = null;
         var _loc7_:Date = null;
         var _loc9_:Date = null;
         var _loc4_:Object = null;
         var _loc2_:VIPModel = null;
         var _loc10_:Object = null;
         var _loc12_:WildSoulInfo = null;
         var _loc8_:Date = null;
         var _loc6_:Date = null;
         var _loc5_:Object = null;
         var _loc1_:MountTemplate = TempleteManager.instance.mountTemplateDic[_data.TemplateId];
         if(_loc1_)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc1_.NeedItemId);
            if(_loc3_ && _loc3_.Property2 > 0 && _loc1_.TemplateId == 3002 && _loc1_.TemplateId == 3005)
            {
               _loc11_ = MountsManager.instance.avatarList.getWildSoulInfo(_data.TemplateId);
               if(_loc11_ && _loc11_.validity > 0)
               {
                  _countDownTxt.visible = true;
                  _loc7_ = _loc11_.expairDate;
                  _loc9_ = PlayerManager.instance.currentPlayerModel.sysCurtime;
                  _loc4_ = DateFormatter.compareDate(_loc9_,_loc7_);
                  if(_loc4_["day"] > 0)
                  {
                     _countDownTxt.text = LanguageMgr.GetTranslation("mounts.WildSoulItem.countDownTxt01",_loc4_["day"]);
                  }
                  else if(_loc4_["hour"] > 0)
                  {
                     _countDownTxt.text = LanguageMgr.GetTranslation("mounts.WildSoulItem.countDownTxt02",_loc4_["hour"]);
                  }
                  else
                  {
                     _countDownTxt.text = LanguageMgr.GetTranslation("mounts.WildSoulItem.countDownTxt03",_loc4_["min"]);
                  }
               }
               else
               {
                  _countDownTxt.visible = false;
               }
            }
            else if(_data.MountType == 3)
            {
               _loc2_ = FrameControllerManager.instance.vipController.model;
               if(_loc2_.vipInfo.ExpirData.time / 1000 > PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond)
               {
                  _countDownTxt.visible = true;
                  _loc10_ = DateFormatter.compareDate2(PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000,_loc2_.vipInfo.ExpirData.time);
                  if(_loc10_["day"] > 0)
                  {
                     _countDownTxt.text = LanguageMgr.GetTranslation("mounts.WildSoulItem.countDownTxt01",_loc10_["day"]);
                  }
                  else
                  {
                     _countDownTxt.text = LanguageMgr.GetTranslation("mounts.WildSoulItem.countDownTxt02",_loc10_["hour"]);
                  }
               }
            }
            else if(_loc1_.TemplateId == 3002 || _loc1_.TemplateId == 3005 || _loc1_.TemplateId == 1132)
            {
               _loc12_ = MountsManager.instance.avatarList.getWildSoulInfo(_data.TemplateId);
               if(_loc12_ && _loc12_.validity > 0)
               {
                  _countDownTxt.visible = true;
                  _loc8_ = _loc12_.expairDate;
                  _loc6_ = PlayerManager.instance.currentPlayerModel.sysCurtime;
                  _loc5_ = DateFormatter.compareDate(_loc6_,_loc8_);
                  if(_loc5_["day"] > 0)
                  {
                     _countDownTxt.text = LanguageMgr.GetTranslation("mounts.WildSoulItem.countDownTxt01",_loc5_["day"]);
                  }
                  else if(_loc5_["hour"] > 0)
                  {
                     _countDownTxt.text = LanguageMgr.GetTranslation("mounts.WildSoulItem.countDownTxt02",_loc5_["hour"]);
                  }
                  else
                  {
                     _countDownTxt.text = LanguageMgr.GetTranslation("mounts.WildSoulItem.countDownTxt03",_loc5_["min"]);
                  }
               }
               else
               {
                  _countDownTxt.visible = false;
               }
            }
            else
            {
               _countDownTxt.visible = false;
            }
         }
      }
      
      private function clear() : void
      {
         lock();
         this.tipData = "";
         _nameTxt.text = "";
         _gradeTxt.text = "";
         _nameTxt.setFrame(1);
         _gradeTxt.setFrame(1);
         _vipFlag.visible = false;
         this._canvas.bitmapData.dispose();
         _starBox.visible = false;
         _promotBtn.visible = false;
         _descTxt.text = "";
         _kingTrainBtn.visible = false;
         _kingBoard.visible = false;
      }
      
      private function __onLoaded(param1:LoaderInfo, param2:Object) : void
      {
         var _loc5_:BitmapData = null;
         var _loc6_:Matrix = null;
         var _loc3_:Rectangle = null;
         if(isDie || !_data)
         {
            return;
         }
         var _loc4_:MovieClip = param2 as MovieClip;
         if(_loc4_)
         {
            _loc4_.gotoAndStop(2);
            _loc5_ = new BitmapData(500,500,true,0);
            _loc6_ = new Matrix();
            _loc6_.ty = 50;
            _loc5_.draw(_loc4_,_loc6_);
            _loc3_ = _loc5_.getColorBoundsRect(4278190080,0,false);
            _canvas.bitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _canvas.bitmapData.copyPixels(_loc5_,_loc3_,new Point(),null,null,true);
            _canvas.width = _loc3_.width * 0.6;
            _canvas.height = _loc3_.height * 0.6;
            if(data && data.TemplateId == 1003)
            {
               _canvas.width = _loc3_.width * 0.4;
               _canvas.height = _loc3_.height * 0.4;
            }
            _loc5_.dispose();
            _canvas.x = int((165 - _canvas.width) / 2);
            if(_data.TemplateId == 1111)
            {
               _canvas.y = int((130 - _canvas.height) / 2) - 10;
            }
            else
            {
               _canvas.y = 10 + int((130 - _canvas.height) / 2);
            }
         }
         _loc4_ = null;
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      private function lock() : void
      {
         addChild(_lock);
         _promotBtn.enable = false;
         _kingTrainBtn.enable = false;
         _isLock = true;
         this.filters = [UIFilter.getGrayFilter()];
      }
      
      private function unlock() : void
      {
         _lock.parent && removeChild(_lock);
         _promotBtn.enable = true;
         _kingTrainBtn.enable = true;
         _isLock = false;
         this.filters = [];
      }
      
      private function get wildSoulCollection() : WildSoulCollection
      {
         return MountsManager.instance.avatarList;
      }
      
      private function get mountInfo() : MountInfo
      {
         return MountsManager.instance.mountInfo;
      }
      
      public function flash() : void
      {
         if(_flashMc)
         {
            _flashMc.play();
         }
      }
      
      public function unFlash() : void
      {
         if(_flashMc)
         {
            _flashMc.gotoAndStop(1);
         }
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         removeEvent();
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onLoaded);
         uinitView();
         _data = null;
         super.dispose();
      }
   }
}

