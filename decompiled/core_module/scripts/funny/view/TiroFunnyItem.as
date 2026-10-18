package funny.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyRewardData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class TiroFunnyItem extends Sprite implements Disposeable
   {
      
      private var _data:FunnyBagData;
      
      private var _splitLine:Bitmap;
      
      private var _hBoxContainer:Sprite;
      
      private var _hBoxList:Vector.<HBox>;
      
      private var _title01:FilterFrameText;
      
      private var _getBtn:BaseButton;
      
      private var _getImg:Bitmap;
      
      private var _itemList:Array;
      
      private var _effList:Array;
      
      private var _firstKillIcon:Bitmap;
      
      private var _firstKillTxt:GradientText;
      
      private const PER_ROW_COUNT:uint = 4;
      
      private var _filterState:Boolean = true;
      
      public function TiroFunnyItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.funny.tiroFunnySplitLine");
         _hBoxContainer = new Sprite();
         _hBoxList = new Vector.<HBox>();
         _title01 = ComponentFactory.Instance.creatComponentByStylename("funny.tiroFunny.title01");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("funny.tiroFunny.getBtn");
         _getImg = ComponentFactory.Instance.creatBitmap("asset.funny.tiroFunny.getImg");
         _firstKillTxt = ComponentFactory.Instance.creatComponentByStylename("funny.tiroFunny.firsstKillGradientText");
         _firstKillIcon = ComponentFactory.Instance.creatBitmap("asset.funny.firstKillIcon");
         addChild(_splitLine);
         addChild(_hBoxContainer);
         addChild(_title01);
         _title01.visible = false;
         addChild(_getBtn);
         _getBtn.visible = false;
         addChild(_getImg);
         _getImg.visible = false;
         addChild(_firstKillIcon);
         _firstKillIcon.visible = false;
         addChild(_firstKillTxt);
         _firstKillTxt.visible = false;
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",__getBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",__getBtnHandler);
      }
      
      private function __getBtnHandler(param1:MouseEvent) : void
      {
         if(FunnyManager.instance.getTiroFunnyDataByActivityId().endTime <= PlayerManager.instance.currentPlayerModel.nowDate)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate"));
            return;
         }
         FunnyManager.instance.sedGetTiroBag(2,data.id);
      }
      
      public function set data(param1:FunnyBagData) : void
      {
         var _loc9_:HBox = null;
         var _loc6_:int = 0;
         var _loc3_:* = undefined;
         var _loc10_:FunnyRewardData = null;
         var _loc7_:GoodsInfo = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc11_:MovieImage = null;
         var _loc8_:MovieImage = null;
         if(!param1)
         {
            return;
         }
         _data = param1;
         if(!_itemList)
         {
            _itemList = [];
         }
         else
         {
            clearAll(_itemList);
         }
         if(!_effList)
         {
            _effList = [];
         }
         else
         {
            clearAll(_effList);
         }
         for each(_loc9_ in _hBoxList)
         {
            _loc9_.disposeAllChildren();
         }
         _title01.visible = true;
         _getBtn.visible = true;
         _getImg.visible = false;
         _title01.htmlText = data.tiroTitle;
         var _loc2_:Vector.<FunnyRewardData> = _data.rewardList;
         var _loc5_:int = int(_loc2_.length);
         _loc6_ = 0;
         for(; _loc6_ < _loc5_; _loc6_++)
         {
            _loc10_ = _loc2_[_loc6_];
            if(_loc10_.temType == 1)
            {
               _loc3_ = ComponentFactory.Instance.creatCustomObject("funny.tiroFunny.BaseItemView");
               _loc9_ = getHBoxByIndex(_loc6_);
               _loc7_ = new GoodsInfo();
               _loc7_.templateId = _loc10_.temId;
               _loc7_.count = _loc10_.count;
               _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc7_.templateId);
               if(!filterEquip(_loc7_))
               {
                  continue;
               }
               _loc9_.addChild(_loc3_);
               if(_filterState)
               {
                  if(_loc4_.Profile >= 5)
                  {
                     _loc11_ = ComponentFactory.Instance.creatComponentByStylename("funny.tirofunny.itemEffect");
                     _loc11_.mouseChildren = _loc11_.mouseEnabled = false;
                     _loc3_.addChild(_loc11_);
                     _effList.push(_loc11_);
                  }
                  else if(_loc4_.Profile == 4)
                  {
                     _loc8_ = ComponentFactory.Instance.creatComponentByStylename("funny.tirofunny.itemEffect02");
                     _loc8_.mouseChildren = _loc8_.mouseEnabled = false;
                     _loc3_.addChild(_loc8_);
                     _effList.push(_loc8_);
                  }
               }
               _loc3_.data = _loc7_;
            }
            _loc9_.addChild(_loc3_);
            _itemList.push(_loc3_);
         }
         doLayout();
         if(_data.status == 1)
         {
            _getBtn.visible = true;
            _getImg.visible = false;
            _getBtn.enable = true;
            _firstKillTxt.visible = false;
         }
         else if(_data.status == 2)
         {
            _getBtn.visible = false;
            _getImg.visible = true;
            _getBtn.enable = false;
            if(data.conditionList[0].id == 41)
            {
               if(data.param1 == "")
               {
                  _firstKillTxt.visible = false;
               }
               else
               {
                  _firstKillIcon.visible = true;
                  _firstKillTxt.visible = true;
                  _firstKillTxt.text = data.param1;
                  _getBtn.visible = false;
                  _getImg.visible = false;
               }
            }
         }
         else if(_data.status == 3)
         {
            _getBtn.visible = true;
            _getImg.visible = false;
            _getBtn.enable = false;
            if(data.conditionList[0].id == 41)
            {
               if(data.param1 == "")
               {
                  _firstKillTxt.visible = false;
               }
               else
               {
                  _firstKillIcon.visible = true;
                  _firstKillTxt.visible = true;
                  _firstKillTxt.text = data.param1;
                  _getBtn.visible = false;
               }
            }
         }
      }
      
      private function doLayout() : void
      {
         var _loc3_:HBox = null;
         var _loc2_:* = 0;
         var _loc4_:uint = _hBoxList[0].displayHeight;
         var _loc1_:uint = _hBoxList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = _hBoxList[_loc2_];
            _loc3_.y = _loc4_ * _loc2_;
            _loc2_++;
         }
         _splitLine.y = _loc4_ * _hBoxList.length - 5;
         _getBtn.x = _splitLine.x + _splitLine.width - (_getBtn.width + 28);
         _getBtn.y = _splitLine.y - _getBtn.height;
         _title01.y = _splitLine.y - _title01.textHeight >> 1;
         _getImg.x = _getBtn.x;
         _getImg.y = _splitLine.y - _getImg.height >> 1;
      }
      
      private function getHBoxByIndex(param1:uint) : HBox
      {
         var _loc3_:HBox = null;
         var _loc2_:uint = Math.floor(param1 / 4);
         if(_loc2_ >= _hBoxList.length)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("funny.tiroFunny.itemHbox");
            _hBoxContainer.addChild(_loc3_);
            _hBoxList.push(_loc3_);
         }
         else
         {
            _loc3_ = _hBoxList[_loc2_];
         }
         return _hBoxList[_loc2_];
      }
      
      public function setfilterstate(param1:Boolean) : void
      {
         if(_filterState == param1)
         {
            return;
         }
         _filterState = param1;
         if(!_filterState)
         {
            _hBoxContainer.filters = [UIFilter.getBlackFilter()];
            _title01.filters = [UIFilter.getBlackFilter()];
            _getBtn.filters = [UIFilter.getBlackFilter()];
            _getImg.filters = [UIFilter.getBlackFilter()];
            _getBtn.enable = false;
         }
         else
         {
            _hBoxContainer.filters = null;
            _title01.filters = null;
            _getBtn.filters = null;
            _getImg.filters = null;
         }
      }
      
      public function get data() : FunnyBagData
      {
         return _data;
      }
      
      private function clearAll(param1:Array) : void
      {
         if(!param1)
         {
            return;
         }
         while(param1.length > 0)
         {
            ObjectUtils.disposeObject(param1.shift());
         }
      }
      
      public function filterEquip(param1:GoodsInfo) : Boolean
      {
         var _loc2_:int = thane.templateInfo.Job;
         if(param1.templateInfo.Job == "0" || param1.templateInfo.Job == "4" || param1.templateInfo.Job == _loc2_ + "" || param1.templateInfo.Job == "99")
         {
            return true;
         }
         return false;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearAll(_itemList);
         clearAll(_effList);
         ObjectUtils.disposeObject(_splitLine);
         _splitLine = null;
         ObjectUtils.disposeObject(_hBoxContainer);
         _hBoxContainer = null;
         ObjectUtils.disposeObject(_title01);
         _title01 = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_getImg);
         _getImg = null;
         ObjectUtils.disposeObject(_firstKillIcon);
         _firstKillIcon = null;
         ObjectUtils.disposeObject(_firstKillTxt);
         _firstKillTxt = null;
      }
   }
}

