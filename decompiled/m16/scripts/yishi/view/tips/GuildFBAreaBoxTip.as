package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GuildFBDropTempInfo;
   import yishi.datas.templates.GuildFBTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class GuildFBAreaBoxTip extends BaseTip
   {
      
      private var _desTxt:FilterFrameText;
      
      private var _list:SimpleTileList;
      
      private var _itemList:Vector.<BaseItemView>;
      
      private const Max:int = 8;
      
      public function GuildFBAreaBoxTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc1_:BaseItemView = null;
         var _loc2_:int = 0;
         super.init();
         _bg.width = 295;
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.areaNodeTipTitle");
         _list = ComponentFactory.Instance.creatCustomObject("ui.guildfb.areaBoxTitleList",[4]);
         _itemList = new Vector.<BaseItemView>();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            _itemList[_loc2_] = _loc1_;
            _loc2_++;
         }
         addChild(_desTxt);
         addChild(_list);
      }
      
      override protected function updateTransform() : void
      {
         var _loc6_:GuildFBTempInfo = null;
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:BaseItemView = null;
         var _loc8_:GoodsInfo = null;
         var _loc5_:GuildFBDropTempInfo = null;
         var _loc7_:int = 0;
         var _loc1_:Array = tipData as Array;
         ObjectUtils.removeChildAllChildrenFromStage(_list);
         if(_loc1_ != null)
         {
            _loc6_ = TempleteManager.instance.guildFBTempCate.getOneNode(_loc1_[0],_loc1_[1]);
            if(_loc6_)
            {
               _desTxt.text = LanguageMgr.GetTranslation("guildfb.areaRewardBoxTip.Title",_loc6_.conciseName);
               _loc2_ = TempleteManager.instance.guildFBDropTempCate.getTempInfos(_loc6_.AreaDropId);
               _loc4_ = int(_loc2_.length);
               _list.beginChanges();
               _loc7_ = 0;
               while(_loc7_ < 8)
               {
                  _loc3_ = _itemList[_loc7_];
                  if(_loc7_ < _loc4_)
                  {
                     _loc5_ = _loc2_[_loc7_];
                     _loc8_ = new GoodsInfo();
                     _loc8_.templateId = _loc5_.ItemId;
                     _loc8_.count = _loc5_.Count;
                     _loc8_.isBinds = _loc5_.IsBind;
                     _loc8_.validDate = _loc5_.ValidDate;
                     _loc3_.data = _loc8_;
                     _list.addChild(_loc3_);
                  }
                  else
                  {
                     _loc3_.data = null;
                  }
                  _loc7_++;
               }
               _list.commitChanges();
               _bg.height = _list.y + _list.height + 15;
            }
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         for each(var _loc1_:BaseItemView in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         super.dispose();
      }
   }
}

