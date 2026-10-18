package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.kingcontract.KingContractInfo;
   
   public class ExtralKingTips extends BaseTip
   {
      
      private var _title:FilterFrameText;
      
      private var _item:KingTipItem;
      
      private var _kingInfo:KingContractInfo;
      
      private var _box:VBox;
      
      public function ExtralKingTips()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg.width = 155;
         _title = ComponentFactory.Instance.creatComponentByStylename("kingcontract.tips.titleTxt");
         _title.text = LanguageMgr.GetTranslation("yishi.view.resourceBar.ExtraBufferTitle4");
         _box = ComponentFactory.Instance.creatComponentByStylename("tips.TipContain");
         _box.y = 40;
         addChild(_title);
         addChild(_box);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:int = 0;
         _box.removeAllChild();
         if(_data is Array && _data[0] is KingContractInfo)
         {
            _loc1_ = 0;
            while(_loc1_ < _data.length)
            {
               if(_data[_loc1_].templateId != 1)
               {
                  if(_data[_loc1_].templateId != 3)
                  {
                     if(_data[_loc1_].templateId != 7)
                     {
                        _kingInfo = _data[_loc1_] as KingContractInfo;
                        _item = new KingTipItem();
                        _item.data = _kingInfo;
                        _box.addChild(_item);
                     }
                  }
               }
               _loc1_++;
            }
            _box.refreshChildPos();
            _bg.height = _box.y + _box.height + 10;
         }
         _bg.width = _box.x + _box.width + 10;
         if(_bg.width < 160)
         {
            _bg.width = 160;
         }
      }
      
      override public function dispose() : void
      {
         _data = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_item)
         {
            ObjectUtils.disposeObject(_item);
         }
         _item = null;
         if(_kingInfo)
         {
            _kingInfo = null;
         }
         if(_box)
         {
            ObjectUtils.disposeObject(_box);
         }
         _box = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

