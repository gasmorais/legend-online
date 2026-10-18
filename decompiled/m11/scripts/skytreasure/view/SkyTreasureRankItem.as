package skytreasure.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.skytreasure.info.SkyTreasurePlayerRankInfoVO;
   
   public class SkyTreasureRankItem extends Sprite implements Disposeable
   {
      
      private var _data:SkyTreasurePlayerRankInfoVO;
      
      private var _rankText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _countText:FilterFrameText;
      
      private var _selected:Boolean;
      
      public function SkyTreasureRankItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _rankText = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.rankItemView.rankText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.rankItemView.nameText");
         _countText = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.rankItemView.countText");
         addChild(_rankText);
         addChild(_nameText);
         addChild(_countText);
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
      }
      
      private function initEvent() : void
      {
      }
      
      public function set data(param1:SkyTreasurePlayerRankInfoVO) : void
      {
         if(param1 == null || _data == param1)
         {
            return;
         }
         _data = param1;
         _rankText.text = String(_data.rank);
         _nameText.text = _data.nickname;
         _countText.text = String(_data.height);
      }
      
      public function get data() : SkyTreasurePlayerRankInfoVO
      {
         return _data;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_data);
         _data = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_countText);
         _countText = null;
      }
   }
}

