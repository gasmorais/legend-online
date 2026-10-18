package singlepass.bugle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.view.community.BaseItemView;
   
   public class SinglePassBugleItemView extends Sprite
   {
      
      private var _goods:BaseItemView;
      
      private var _goodsInfo:GoodsInfo;
      
      private var _effectMovie:MovieClip;
      
      private var _costContainer:Sprite;
      
      private var _costBg:Image;
      
      private var _goodsTxt:FilterFrameText;
      
      private var _pointsTxt:FilterFrameText;
      
      private var _pointsIcon:Image;
      
      private var _itemsTxt:FilterFrameText;
      
      private var _itemsIcon:Image;
      
      private var _tempData:GoodsInfo;
      
      public var timeout:Boolean = false;
      
      public var isPay:Boolean;
      
      public var index:int;
      
      public var isChested:Boolean = false;
      
      private var _filter:SimpleBuildingFilter = new SimpleBuildingFilter();
      
      public function SinglePassBugleItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         mouseEnabled = false;
         _effectMovie = ComponentFactory.Instance.creatCustomObject("singlepass.bugle.ItemEffect");
         _goodsTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.bugle.GoodsNameTxt");
         _costContainer = ComponentFactory.Instance.creatCustomObject("singlepass.bugle.CostContainer");
         _costBg = ComponentFactory.Instance.creatComponentByStylename("singlepass.BugleItemCostBg");
         _pointsTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.bugle.PointsTxt");
         _pointsIcon = ComponentFactory.Instance.creatComponentByStylename("singlepass.bugle.PointsIcon");
         _itemsTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.bugle.ItemsTxt");
         _itemsIcon = ComponentFactory.Instance.creatComponentByStylename("singlepass.bugle.ItemsIcon");
         _goods = ComponentFactory.Instance.creatCustomObject("singlepass.bugle.GoodsItem");
         _costContainer.addChild(_costBg);
         _costContainer.addChild(_pointsTxt);
         _costContainer.addChild(_pointsIcon);
         _costContainer.addChild(_itemsTxt);
         _costContainer.addChild(_itemsIcon);
         addChild(_effectMovie);
         _effectMovie.gotoAndStop(1);
         _effectMovie["content"].addChild(_goodsTxt);
         _effectMovie["content"].addChild(_goods);
         _effectMovie["content"].addChild(_costContainer);
         resetCost();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeViolentMc(_effectMovie);
         _effectMovie = null;
         ObjectUtils.disposeObject(_goodsTxt);
         _goodsTxt = null;
         ObjectUtils.disposeObject(_pointsTxt);
         _pointsTxt = null;
         ObjectUtils.disposeObject(_pointsIcon);
         _pointsIcon = null;
         ObjectUtils.disposeObject(_itemsTxt);
         _itemsTxt = null;
         ObjectUtils.disposeObject(_itemsIcon);
         _itemsIcon = null;
         ObjectUtils.disposeObject(_goods);
         _goods = null;
         _goodsInfo = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initEvent() : void
      {
         addEventListener("rollOver",__rollOverHandler);
         addEventListener("rollOut",__rollOutHandler);
         _effectMovie.addEventListener("complete",__completeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__rollOverHandler);
         removeEventListener("rollOut",__rollOutHandler);
         _effectMovie && _effectMovie.removeEventListener("complete",__completeHandler);
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         _filter.setLightFilter(this);
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         _filter.setNormalFilter(this);
      }
      
      private function __completeHandler(param1:Event) : void
      {
         _effectMovie["content"].addChild(_goodsTxt);
         _effectMovie["content"].addChild(_goods);
         _effectMovie["content"].addChild(_costContainer);
         _goodsTxt.visible = true;
         _goods.visible = true;
      }
      
      public function playReverseBack() : void
      {
         _effectMovie.gotoAndPlay("f_1");
         _effectMovie["content"].addChild(_goodsTxt);
         _effectMovie["content"].addChild(_goods);
         _effectMovie["content"].addChild(_costContainer);
         _goodsTxt.visible = false;
         _goods.visible = false;
      }
      
      public function playReversePre() : void
      {
         _effectMovie.gotoAndPlay("f_2");
         _effectMovie["content"].addChild(_goodsTxt);
         _effectMovie["content"].addChild(_goods);
         _goodsTxt.visible = false;
         _goods.visible = false;
      }
      
      public function playF1() : void
      {
         _effectMovie.gotoAndStop("f_1");
         _effectMovie["content"].addChild(_goodsTxt);
         _effectMovie["content"].addChild(_goods);
         _goodsTxt.visible = true;
         _goods.visible = true;
      }
      
      public function playF2() : void
      {
         _effectMovie.gotoAndStop("f_2");
         _effectMovie["content"].addChild(_costContainer);
         _costContainer.visible = true;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         var _loc2_:GoodsTemplateInfo = null;
         _tempData = param1;
         if(_tempData)
         {
            _goods.showProfile = true;
            _goods.data = _tempData;
            if(_tempData.templateId == -100 || _tempData.templateId == -200 || _tempData.templateId == -300)
            {
               ShowTipManager.Instance.removeTip(_goods);
            }
            _loc2_ = _tempData.templateInfo;
            if(_loc2_)
            {
               _goodsTxt.text = _loc2_.TemplateName;
               _goodsTxt.setFrame(_loc2_.Profile);
               if(_goodsTxt.numLines == 1)
               {
                  _goodsTxt.y = 25;
               }
               else if(_goodsTxt.numLines == 2)
               {
                  _goodsTxt.y = 15;
               }
               else
               {
                  _goodsTxt.y = 10;
               }
            }
         }
      }
      
      public function resetCost() : void
      {
         _costContainer.visible = false;
      }
      
      public function updateCost(param1:int = 0, param2:int = 1) : void
      {
         _pointsTxt.text = param1.toString();
         _itemsTxt.text = param2.toString();
         if(param1 > 0)
         {
            _pointsTxt.visible = true;
            _pointsIcon.visible = true;
         }
         else
         {
            _pointsTxt.visible = false;
            _pointsIcon.visible = false;
         }
      }
      
      public function updateData(param1:GoodsInfo) : void
      {
         _goodsInfo = param1;
         initData();
         playReversePre();
         isChested = true;
         resetCost();
      }
      
      private function initData() : void
      {
         this.buttonMode = false;
         _goods.data = _goodsInfo;
         addChild(_goods);
         if(_goodsInfo.templateId == -100 || _goodsInfo.templateId == -200 || _goodsInfo.templateId == -300)
         {
            ShowTipManager.Instance.removeTip(_goods);
         }
         var _loc1_:GoodsTemplateInfo = _goodsInfo.templateInfo;
         _goodsTxt.text = _loc1_.TemplateName;
         _goodsTxt.setFrame(_loc1_.Profile);
         if(_goodsTxt.numLines == 1)
         {
            _goodsTxt.y = 25;
         }
         else if(_goodsTxt.numLines == 2)
         {
            _goodsTxt.y = 15;
         }
         else
         {
            _goodsTxt.y = 10;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

