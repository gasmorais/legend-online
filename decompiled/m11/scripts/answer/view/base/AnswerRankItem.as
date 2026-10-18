package answer.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class AnswerRankItem extends Sprite
   {
      
      private var _rank:FilterFrameText;
      
      private var _nick:FilterFrameText;
      
      private var _score:FilterFrameText;
      
      private var _icon:Bitmap;
      
      private const RANK_TF_ARRAY:Array = ["answer.answer_rank1_t","answer.answer_rank2_t","answer.answer_rank3_t","answer.answer_rank4_t"];
      
      private const RANK_ICON_ARRAY:Array = ["asset.answer.rank_first","asset.answer.rank_secend","asset.answer.rank_third"];
      
      public function AnswerRankItem()
      {
         super();
         initView();
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.lineStyle(1,0,0);
         _loc1_.graphics.lineTo(0,25);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
      }
      
      private function initView() : void
      {
         _rank = ComponentFactory.Instance.creatComponentByStylename("answer.rank.rankv_txt");
         _nick = ComponentFactory.Instance.creatComponentByStylename("answer.rank.nickv_txt");
         _score = ComponentFactory.Instance.creatComponentByStylename("answer.rank.scorev_txt");
         addChild(_rank);
         addChild(_nick);
         addChild(_score);
      }
      
      public function setView(param1:int, param2:String, param3:int) : void
      {
         _rank.text = param1 + "";
         _nick.text = param2;
         _score.text = param3 + "";
         if(_icon)
         {
            removeChild(_icon);
         }
         if(param1 < 4)
         {
            _rank.textFormatStyle = RANK_TF_ARRAY[param1 - 1];
            _nick.textFormatStyle = RANK_TF_ARRAY[param1 - 1];
            _score.textFormatStyle = RANK_TF_ARRAY[param1 - 1];
            _icon = ComponentFactory.Instance.creatBitmap(RANK_ICON_ARRAY[param1 - 1]);
            addChild(_icon);
         }
         else
         {
            _rank.textFormatStyle = RANK_TF_ARRAY[3];
            _nick.textFormatStyle = RANK_TF_ARRAY[3];
            _score.textFormatStyle = RANK_TF_ARRAY[3];
            _icon = ComponentFactory.Instance.creatBitmap(RANK_ICON_ARRAY[0]);
            _icon.visible = false;
            addChild(_icon);
         }
      }
   }
}

