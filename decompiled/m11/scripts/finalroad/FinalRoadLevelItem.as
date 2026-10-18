package finalroad
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.finalroad.FinalRoadEventRspMsg;
   import flash.display.Bitmap;
   import mvc.module.finalroad.FinalRoadModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.FinalRoadEventTempInfo;
   import yishi.datas.templates.FinalRoadGroupTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FinalRoadManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class FinalRoadLevelItem extends Component implements ISelectable
   {
      
      private var _bg:Bitmap;
      
      private var _propertyIcon:ScaleFrameImage;
      
      private var _icon:BaseIconView;
      
      private var _selectedBg:Bitmap;
      
      private var _bottomBg1:Bitmap;
      
      private var _bottomBg2:Bitmap;
      
      private var _rewardsImg:Bitmap;
      
      private var _selected:Boolean;
      
      private var _txt:FilterFrameText;
      
      private var _hBox:HBox;
      
      public function FinalRoadLevelItem()
      {
         super();
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.finalRoadLevelItem.bg");
         _propertyIcon = ComponentFactory.Instance.creatComponentByStylename("finalRoadLevelItem.propertyIcon");
         _icon = ComponentFactory.Instance.creatCustomObject("finalRoadLevelItem.icon");
         _selectedBg = ComponentFactory.Instance.creatBitmap("asset.finalRoadLevelItem.selectedBg");
         _bottomBg1 = ComponentFactory.Instance.creatBitmap("asset.finalRoadLevelItem.bottomBg1");
         _bottomBg2 = ComponentFactory.Instance.creatBitmap("asset.finalRoadLevelItem.bottomBg2");
         _rewardsImg = ComponentFactory.Instance.creatBitmap("asset.finalRoadLevelItem.rewardsImg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("finalRoadLevelItem.txt");
         _hBox = ComponentFactory.Instance.creatCustomObject("finalRoadLevelItem.hBox");
         addChild(_bg);
         addChild(_icon);
         addChild(_propertyIcon);
         addChild(_selectedBg);
         addChild(_bottomBg1);
         addChild(_bottomBg2);
         addChild(_rewardsImg);
         addChild(_txt);
         addChild(_hBox);
         _selectedBg.visible = false;
      }
      
      public function set data(param1:FinalRoadEventRspMsg) : void
      {
         var _loc10_:FinalRoadEventTempInfo = null;
         var _loc2_:Array = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:SkillTempInfo = null;
         var _loc11_:FinalRoadGroupTempInfo = null;
         var _loc4_:Array = null;
         var _loc6_:int = 0;
         var _loc12_:Array = null;
         var _loc13_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         if(!param1)
         {
            return;
         }
         var _loc8_:FinalRoadEventTempInfo = TempleteManager.instance.finalRoadEventTempCate.getTempInfoById(param1.monster);
         if(_loc8_)
         {
            _propertyIcon.setFrame(int(_loc8_.Para3));
            _icon.icon = IconFactory.getIncreasinglyBossIcon(_loc8_.Para4);
         }
         if(param1.buff > 0)
         {
            this.removeChild(_bottomBg2);
            _rewardsImg.x = 10;
            _loc10_ = TempleteManager.instance.finalRoadEventTempCate.getTempInfoById(param1.buff);
            if(_loc10_)
            {
               _loc2_ = _loc10_.Para1.split(",");
               _loc5_ = 0;
               while(_loc5_ < _loc2_.length)
               {
                  _loc7_ = int(_loc2_[_loc5_]);
                  _loc9_ = TempleteManager.instance.skillTemplateDic[_loc7_];
                  if(_loc9_)
                  {
                     _txt.text += _loc9_.Description + "\n";
                  }
                  _loc5_++;
               }
            }
         }
         else
         {
            _bottomBg1.visible = false;
            _rewardsImg.x = -35;
            _loc11_ = TempleteManager.instance.finalRoadGroupTempCate.getTempInfoById(param1.reward);
            if(_loc11_)
            {
               _hBox.removeAllChild();
               _loc4_ = _loc11_.Reward.split("|");
               _loc6_ = 0;
               while(_loc6_ < _loc4_.length)
               {
                  _loc12_ = _loc4_[_loc6_].split(",");
                  _loc13_ = new GoodsInfo();
                  _loc13_.templateId = _loc12_[0];
                  _loc13_.count = _loc12_[1];
                  _loc3_ = ComponentFactory.Instance.creatCustomObject("finalRoadLevelItem.baseItemView");
                  _loc3_.data = _loc13_;
                  _hBox.addChild(_loc3_);
                  _loc6_++;
               }
            }
         }
      }
      
      public function refreshView() : void
      {
         if(model && model.groupInfo)
         {
            if(model.groupInfo.state == 1)
            {
               this.filters = [UIFilter.getGrayFilter()];
               this.mouseChildren = this.mouseEnabled = false;
            }
            else
            {
               this.filters = [];
               this.mouseChildren = this.mouseEnabled = true;
            }
         }
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
         _selected = param1;
         _selectedBg.visible = _selected;
      }
      
      private function get model() : FinalRoadModel
      {
         return FinalRoadManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_propertyIcon);
         _propertyIcon = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_selectedBg);
         _selectedBg = null;
         ObjectUtils.disposeObject(_bottomBg1);
         _bottomBg1 = null;
         ObjectUtils.disposeObject(_bottomBg2);
         _bottomBg2 = null;
         ObjectUtils.disposeObject(_rewardsImg);
         _rewardsImg = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
         super.dispose();
      }
   }
}

